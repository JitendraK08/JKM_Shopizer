/*
 * Licensed to csti consulting 
 * You may obtain a copy of the License at
 *
 * http://www.csticonsulting.com
 * Copyright (c) 2006-Aug 25, 2010 Consultation CS-TI inc. 
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package com.salesmanager.catalog.common;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import uk.ltd.getahead.dwr.WebContextFactory;

import com.salesmanager.catalog.product.ProductAttribute;
import com.salesmanager.checkout.util.MiniShoppingCartUtil;
import com.salesmanager.core.entity.catalog.Product;
import com.salesmanager.core.entity.common.I18NEntity;
import com.salesmanager.core.entity.merchant.MerchantStore;
import com.salesmanager.core.entity.orders.ShoppingCart;
import com.salesmanager.core.entity.orders.ShoppingCartProduct;
import com.salesmanager.core.entity.orders.ShoppingCartProductAttribute;
import com.salesmanager.core.service.ServiceFactory;
import com.salesmanager.core.service.catalog.CatalogService;
import com.salesmanager.core.util.CurrencyUtil;
import com.salesmanager.core.util.LabelUtil;
import com.salesmanager.core.util.ProductUtil;
import com.salesmanager.core.util.www.SessionUtil;

/**
 * Mini cart actions
 * 
 * @author Carl Samson
 * 
 */
public class AjaxCatalogUtil {

	private static Logger logger = Logger.getLogger(AjaxCatalogUtil.class);

	public ShoppingCart removeProduct(long productId) {

		HttpServletRequest req = WebContextFactory.get()
				.getHttpServletRequest();

		HttpSession session = req.getSession();

		ShoppingCart cart = SessionUtil.getMiniShoppingCart(req);

		MerchantStore store = (MerchantStore) session.getAttribute("STORE");

		Locale locale = (Locale) session.getAttribute("WW_TRANS_I18N_LOCALE");

		if (cart != null) {

			Collection productsCollection = cart.getProducts();

			Collection newProductsCollection = new ArrayList();

			if (productsCollection != null) {
				Iterator i = productsCollection.iterator();
				while (i.hasNext()) {
					ShoppingCartProduct scp = (ShoppingCartProduct) i.next();
					if (scp.getProductId() == productId) {
						continue;
					}
					newProductsCollection.add(scp);
				}
			}
			cart.setProducts(newProductsCollection);
		}

		MiniShoppingCartUtil.calculateTotal(cart, store);

		return cart;
	}

	public String setPrice(ProductAttribute[] attributes, String productId) {

		if (StringUtils.isBlank(productId)) {
			return "";
		}

		HttpServletRequest req = WebContextFactory.get()
				.getHttpServletRequest();

		HttpSession session = req.getSession();

		ShoppingCart cart = SessionUtil.getMiniShoppingCart(req);

		MerchantStore store = (MerchantStore) session.getAttribute("STORE");

		Locale locale = (Locale) session.getAttribute("WW_TRANS_I18N_LOCALE");

		String price = "";

		// get original product price
		try {

			CatalogService cservice = (CatalogService) ServiceFactory
					.getService(ServiceFactory.CatalogService);
			Product p = cservice.getProduct(Long.valueOf(productId));
			if (p == null) {
				return "";
			}

			if (attributes != null && attributes.length > 0) {
				List ids = new ArrayList();
				for (int i = 0; i < attributes.length; i++) {
					if (!attributes[i].isStringValue()) {
						ids.add(new Long(attributes[i].getValue()));
					}
				}
				Collection attrs = cservice.getProductAttributes(ids, locale
						.getLanguage());

				if (attrs != null && attrs.size() > 0) {
					price = ProductUtil.formatHTMLProductPriceWithAttributes(
							locale, store.getCurrency(), p, attrs, false);
				}
			}

		} catch (Exception e) {
			logger.error(e);
		}

		return price;

	}

	public ShoppingCart addProductWithAttributes(long productId, int quantity,
			ProductAttribute[] attributes) {
		HttpServletRequest req = WebContextFactory.get()
				.getHttpServletRequest();
		return addProductToCart(req, productId, quantity, attributes);
	}

	public ShoppingCart addProductNoAttributes(long productId, int quantity) {
		HttpServletRequest req = WebContextFactory.get()
				.getHttpServletRequest();
		return addProductToCart(req, productId, quantity, null);
	}

	/**
	 * Add product to shopping cart
	 * 
	 * @param productId
	 * @param quantity
	 * @param attributes
	 * @return
	 */
	public ShoppingCart addProductToCart(HttpServletRequest req,
			long productId, int quantity, ProductAttribute[] attributes) {

		HttpSession session = req.getSession();

		ShoppingCart cart = SessionUtil.getMiniShoppingCart(req);

		MerchantStore store = (MerchantStore) session.getAttribute("STORE");

		if (store == null) {
			cart = new ShoppingCart();
			LabelUtil label = LabelUtil.getInstance();
			label.setLocale(req.getLocale());
			String msg = label.getText("error.sessionexpired");
			cart.setErrorMessage(msg);
			return cart;
		}

		Locale locale = (Locale) session.getAttribute("WW_TRANS_I18N_LOCALE");

		if (cart == null) {
			cart = new ShoppingCart();
		}

		try {

			// get products
			Collection productsCollection = cart.getProducts();

			CatalogService cservice = (CatalogService) ServiceFactory
					.getService(ServiceFactory.CatalogService);
			Product p = cservice.getProduct(productId);

			if (p == null || store == null) {
				String message = LabelUtil.getInstance().getText(locale,
						"errors.addtocart");
				cart.setErrorMessage(message);
				return cart;
			}

			((I18NEntity) p).setLocale(locale, store.getCurrency());

			if (p.getMerchantId() != store.getMerchantId())
				return cart;

			boolean productFound = false;
			if (productsCollection != null && attributes == null) {
				Iterator i = productsCollection.iterator();
				while (i.hasNext()) {
					ShoppingCartProduct scp = (ShoppingCartProduct) i.next();
					if (scp.getProductId() == productId) {
						int qty = scp.getQuantity();
						scp.setQuantity(qty + quantity);
						productFound = true;
						break;
					}
				}
			}

			if (!productFound) {

				ShoppingCartProduct scp = new ShoppingCartProduct();
				scp.setProductId(p.getProductId());
				scp.setQuantity(quantity);
				if (!StringUtils.isBlank(p.getSmallImagePath())) {
					scp.setImage(p.getSmallImagePath());
				} else if (!StringUtils.isBlank(p.getLargeImagePath())) {
					scp.setImage(p.getLargeImagePath());
				} else {
					// nothing for now
				}

				if (attributes != null && attributes.length > 0) {
					Map ids = new HashMap();
					for (int i = 0; i < attributes.length; i++) {
						ids.put(new Long(attributes[i].getName()),
								attributes[i]);
					}
					Collection attrs = cservice.getProductAttributes(
							new ArrayList(ids.keySet()), locale.getLanguage());

					if (attrs != null && attrs.size() > 0) {
						BigDecimal priceWithAttributes = ProductUtil
								.determinePriceWithAttributes(p, attrs, locale,
										store.getCurrency());
						scp.setPrice(priceWithAttributes);
						scp.setPriceText(CurrencyUtil
								.displayFormatedAmountWithCurrency(
										priceWithAttributes, store
												.getCurrency()));

						Iterator attrIt = attrs.iterator();
						List attrList = new ArrayList();
						while (attrIt.hasNext()) {
							com.salesmanager.core.entity.catalog.ProductAttribute prodAttr = (com.salesmanager.core.entity.catalog.ProductAttribute) attrIt
									.next();
							ShoppingCartProductAttribute scpa = new ShoppingCartProductAttribute();
							scpa.setAttributeId(prodAttr
									.getProductAttributeId());
							ProductAttribute pa = (ProductAttribute) ids
									.get(new Long(prodAttr
											.getProductAttributeId()));
							if (pa != null) {
								scpa.setAttributeValue(pa.getValue());
								if (pa.isStringValue()) {
									scpa.setTextValue(pa.getTextValue());
								}
								attrList.add(scpa);
							}
						}
						scp.setAttributes(attrList);

					} else {
						scp.setPrice(ProductUtil.determinePrice(p, locale,
								store.getCurrency()));
						BigDecimal price = ProductUtil.determinePrice(p,
								locale, store.getCurrency());
						scp.setPriceText(CurrencyUtil
								.displayFormatedAmountWithCurrency(price, store
										.getCurrency()));
					}
				} else {
					scp.setPrice(ProductUtil.determinePrice(p, locale, store
							.getCurrency()));
					BigDecimal price = ProductUtil.determinePrice(p, locale,
							store.getCurrency());
					scp.setPriceText(CurrencyUtil
							.displayFormatedAmountWithCurrency(price, store
									.getCurrency()));
				}
				scp.setProductName(p.getName());

				Collection products = cart.getProducts();
				if (products == null) {
					products = new ArrayList();
					cart.setProducts(products);
				}
				products.add(scp);
			}

			MiniShoppingCartUtil.calculateTotal(cart, store);

			SessionUtil.setMiniShoppingCart(cart, req);

			return cart;

		} catch (Exception e) {
			logger.error(e);
			cart.setErrorMessage(LabelUtil.getInstance().getText(locale,
					"errors.technical"));
			return cart;
		}

	}

}
