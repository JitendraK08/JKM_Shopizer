/*
 * Provided by CSTI Consulting 
 * Following GNU LESSER GENERAL PUBLIC LICENSE
 * You may obtain more details at
 *
 * http://www.csticonsulting.com
 * Copyright (c) 2006-2010 Consultation CS-TI inc. 
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package com.salesmanager.central.profile;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.commons.configuration.Configuration;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.salesmanager.central.BaseAction;
import com.salesmanager.central.util.LanguageHelper;
import com.salesmanager.central.util.PropertiesHelper;
import com.salesmanager.central.web.MenuFactory;
import com.salesmanager.central.web.ZoneMap;
import com.salesmanager.core.constants.ConfigurationConstants;
import com.salesmanager.core.constants.Constants;
import com.salesmanager.core.constants.ErrorConstants;
import com.salesmanager.core.entity.merchant.MerchantConfiguration;
import com.salesmanager.core.entity.merchant.MerchantRegistration;
import com.salesmanager.core.entity.merchant.MerchantStore;
import com.salesmanager.core.entity.merchant.MerchantUserInformation;
import com.salesmanager.core.entity.orders.Order;
import com.salesmanager.core.entity.orders.SearchOrderResponse;
import com.salesmanager.core.entity.orders.SearchOrdersCriteria;
import com.salesmanager.core.entity.reference.Country;
import com.salesmanager.core.entity.system.CentralFunction;
import com.salesmanager.core.service.ServiceException;
import com.salesmanager.core.service.ServiceFactory;
import com.salesmanager.core.service.cache.RefCache;
import com.salesmanager.core.service.catalog.CatalogService;
import com.salesmanager.core.service.merchant.ConfigurationRequest;
import com.salesmanager.core.service.merchant.ConfigurationResponse;
import com.salesmanager.core.service.merchant.MerchantService;
import com.salesmanager.core.service.order.OrderService;
import com.salesmanager.core.service.payment.PaymentService;
import com.salesmanager.core.service.shipping.ShippingService;
import com.salesmanager.core.util.EncryptionUtil;
import com.salesmanager.core.util.LabelUtil;
import com.salesmanager.core.util.LanguageUtil;
import com.salesmanager.core.util.MessageUtil;
import com.salesmanager.core.util.PropertiesUtil;

/**
 * This is the entry point for the central system, manages logon/logout process
 * and dashboard display
 * 
 * @author Carl Samson
 * 
 */
public class ProfileLogonAction extends BaseAction {

	private Logger log = Logger.getLogger(ProfileLogonAction.class);

	static Configuration conf = PropertiesHelper.getConfiguration();

	private static int ORDERSQUANTITY = 10;

	static {
		ORDERSQUANTITY = conf.getInt("central.orderlistsummary.maxsize");
	}

	private MerchantStore store;
	private MerchantUserInformation userInformation;

	// Displays last <ORDERSQUANTITY> on the dashboard page
	private List orders = new ArrayList();

	// Displays Shopping Cart counters on the dashboard page
	private List cartCounters = new ArrayList();
	
	
	private String apiKey = null;

	private int countryCode = -1;

	public int getCountryCode() {
		return countryCode;
	}

	public void setCountryCode(int countryCode) {
		this.countryCode = countryCode;
	}

	private int statusMessageCode = -1;// displayed on the dashboard

	private String configurationMessageTitle;
	private Collection<String> configurationMessages;
	private String message;

	private Collection<ZoneMap> zoneMaps;// geo map
	private int zoneMapCount;// geo map
	private boolean zoneMapRegion = false;
	private String countryIsoCode;

	private void checkSales() throws Exception {

		// get sales

		SearchOrdersCriteria criteria = new SearchOrdersCriteria();
		criteria.setMerchantId(super.getContext().getMerchantid());
		criteria.setStartindex(0);
		criteria.setQuantity(-1);

		OrderService oservice = (OrderService) ServiceFactory
				.getService(ServiceFactory.OrderService);
		SearchOrderResponse response = oservice.searchOrders(criteria);
		Collection sales = response.getOrders();

		ShippingService sservice = (ShippingService) ServiceFactory
				.getService(ServiceFactory.ShippingService);
		boolean international = sservice.isShippingInternational(super
				.getContext().getMerchantid());

		boolean nationalMode = false;
		if (sales != null && sales.size() > 0) {

			this.zoneMaps = new ArrayList();

			if (!international
					&& (this.getCountryCode() == Constants.CA_COUNTRY_ID || this
							.getCountryCode() == Constants.US_COUNTRY_ID)) {
				nationalMode = true;
				zoneMapRegion = true;
				Map countries = RefCache.getCountriesMap();
				Country c = (Country) countries.get(this.getCountryCode());
				if (c != null) {
					this.setCountryIsoCode(c.getCountryIsoCode2());
				}
			}

			Map zoneMap = new HashMap();
			Iterator i = sales.iterator();
			while (i.hasNext()) {
				Order order = (Order) i.next();
				String country = order.getBillingCountry();
				String city = order.getBillingCity();
				String finalZone = country;
				if (nationalMode) {
					finalZone = city;
				}
				ZoneMap zm = null;
				if (zoneMap.containsKey(finalZone)) {
					zm = (ZoneMap) zoneMap.get(finalZone);
				} else {
					zm = new ZoneMap();
					zm.setZone(finalZone);
					zoneMap.put(finalZone, zm);
					this.zoneMaps.add(zm);
				}
				int salesCount = zm.getSalesCount() + 1;
				zm.setSalesCount(salesCount);

			}
			this.zoneMapCount = this.zoneMaps.size();
		}

	}

	private void checkConfiguration() throws Exception {

		boolean minimumConfigured = true;

		LabelUtil label = LabelUtil.getInstance();

		List messages = new ArrayList();

		MenuFactory menuFactory = MenuFactory.getInstance();
		Map functions = menuFactory.getFunctionsByFunctionCode();

		MerchantService mservice = (MerchantService) ServiceFactory
				.getService(ServiceFactory.MerchantService);

		// check if MerchantStore exists
		MerchantStore mstore = mservice.getMerchantStore(super.getContext()
				.getMerchantid());

		CentralFunction cfr = (CentralFunction) functions.get("ASTOR01");

		if (mstore == null) {
			messages
					.add("<a href=\""
							+ super.getServletRequest().getContextPath()
							+ cfr.getCentralFunctionUrl()
							+ "\">"
							+ label
									.getText(super.getContext().getLang(),
											"label.dashboard.configurationmessage.storeinformation")
							+ "</a>");
			minimumConfigured = false;
		} else {

			String txt = label.getText(super.getLocale().getLanguage(),
					"label.dashboard.configurationmessage.storeinformation");
			messages.add(txt);
		}

		if (super.getContext().isExistingStore()) {

			// check for any products
			CatalogService cservice = (CatalogService) ServiceFactory
					.getService(ServiceFactory.CatalogService);
			int count = cservice.getProductCount(super.getContext()
					.getMerchantid());
			cfr = (CentralFunction) functions.get("CPRD01");
			if (count == 0) {
				messages
						.add("<a href=\""
								+ super.getServletRequest().getContextPath()
								+ cfr.getCentralFunctionUrl()
								+ "\">"
								+ label
										.getText(super.getLocale()
												.getLanguage(),
												"label.dashboard.configurationmessage.products")
								+ "</a>");
				minimumConfigured = false;
			} else {
				messages.add(label.getText(super.getContext().getLang(),
						"label.dashboard.configurationmessage.products"));
			}

			// check for any payment method

			PaymentService pservice = (PaymentService) ServiceFactory
					.getService(ServiceFactory.PaymentService);

			Collection paymentMethods = pservice
					.getConfiguredPaymentMethods(super.getContext()
							.getMerchantid());
			cfr = (CentralFunction) functions.get("CHPAY01");
			if (paymentMethods == null || paymentMethods.size() == 0) {
				messages
						.add("<a href=\""
								+ super.getServletRequest().getContextPath()
								+ cfr.getCentralFunctionUrl()
								+ "\">"
								+ label
										.getText(super.getLocale()
												.getLanguage(),
												"label.dashboard.configurationmessage.payments")
								+ "</a>");
				minimumConfigured = false;
			} else {
				messages.add(label.getText(super.getLocale().getLanguage(),
						"label.dashboard.configurationmessage.payments"));
			}

			// check for any shipping configuration

			ShippingService sservice = (ShippingService) ServiceFactory
					.getService(ServiceFactory.ShippingService);
			Collection shippingMethods = sservice
					.getShippingModulesNamesConfigured(super.getContext()
							.getMerchantid());

			cfr = (CentralFunction) functions.get("CHSH01");
			if (shippingMethods == null || shippingMethods.size() == 0) {
				messages
						.add("<a href=\""
								+ super.getServletRequest().getContextPath()
								+ cfr.getCentralFunctionUrl()
								+ "\">"
								+ label
										.getText(super.getLocale()
												.getLanguage(),
												"label.dashboard.configurationmessage.shipping")
								+ "</a>");
				minimumConfigured = false;
			} else {
				messages.add(label.getText(super.getLocale().getLanguage(),
						"label.dashboard.configurationmessage.shipping"));
			}

		}

		if (messages != null && messages.size() > 0) {

			if (!minimumConfigured) {
				configurationMessages = new ArrayList();
				this.setConfigurationMessageTitle(getText(
						"label.dashboard.message.0",
						new String[] { PropertiesUtil.getConfiguration()
								.getString("core.systemname") }));
				configurationMessages.addAll(messages);
				this.setStatusMessageCode(0);
			}

			if (minimumConfigured) {
				MerchantUserInformation merchantUserInfo = mservice
						.getMerchantUserInformation(super.getPrincipal()
								.getRemoteUser());
				merchantUserInfo.setStatus(Constants.CENTRAL_STATUS_OK);
				mservice.saveOrUpdateMerchantUserInformation(merchantUserInfo);
			}

		}

	}

	public void showOrderSummary() throws Exception {

		SearchOrdersCriteria criteria = new SearchOrdersCriteria();
		criteria.setMerchantId(super.getContext().getMerchantid());
		criteria.setStartindex(0);
		criteria.setQuantity(ORDERSQUANTITY);

		OrderService oservice = (OrderService) ServiceFactory
				.getService(ServiceFactory.OrderService);
		SearchOrderResponse response = oservice.searchOrders(criteria);
		Collection orderCollection = response.getOrders();

		ShippingService sservice = (ShippingService) ServiceFactory
				.getService(ServiceFactory.ShippingService);
		boolean international = sservice.isShippingInternational(super
				.getContext().getMerchantid());

		boolean nationalMode = false;
		if (orderCollection != null && orderCollection.size() > 0) {

			Map zoneMap = new HashMap();
			this.zoneMaps = new ArrayList();

			if (!international
					&& (this.getCountryCode() == Constants.CA_COUNTRY_ID || this
							.getCountryCode() == Constants.US_COUNTRY_ID)) {
				nationalMode = true;
				zoneMapRegion = true;
				Map countries = RefCache.getCountriesMap();
				Country c = (Country) countries.get(this.getCountryCode());
				if (c != null) {
					this.setCountryIsoCode(c.getCountryIsoCode2());
				}
			}

			this.orders = new ArrayList();
			Iterator i = orderCollection.iterator();
			int count = 1;
			while (i.hasNext()) {
				Order order = (Order) i.next();

				if (count < this.ORDERSQUANTITY) {
					this.orders.add(order);
				}

				String country = order.getBillingCountry();
				String city = order.getBillingCity();
				String finalZone = country;
				if (nationalMode) {
					finalZone = city;
				}
				ZoneMap zm = null;
				if (zoneMap.containsKey(finalZone)) {
					zm = (ZoneMap) zoneMap.get(finalZone);
				} else {
					zm = new ZoneMap();
					zm.setZone(finalZone);
					zoneMap.put(finalZone, zm);
					this.zoneMaps.add(zm);
				}
				int salesCount = zm.getSalesCount() + 1;
				zm.setSalesCount(salesCount);

			}
			this.zoneMapCount = this.zoneMaps.size();

		}

	}

	/**
	 * After logon is executed, this takes care of setting dashboerd's objects
	 * 
	 * @return
	 * @throws Exception
	 */
	public String display() throws Exception {

		Context ctx = (Context) super.getServletRequest().getSession()
				.getAttribute(ProfileConstants.context);

		try {

			if (this.getStore() == null) {

				if (ctx == null) {
					return "ERROR";
				}

				MerchantService service = (MerchantService) ServiceFactory
						.getService(ServiceFactory.MerchantService);
				store = service.getMerchantStore(ctx.getMerchantid());
				String userName = super.getPrincipal().getRemoteUser();
				userInformation = service.getMerchantUserInformation(userName);

			}

			int status = userInformation.getStatus();

			if (store != null) {
				this.setCountryCode(store.getCountry());
				
				String key = EncryptionUtil.generatekey(String.valueOf(store.getMerchantId()));
				apiKey = EncryptionUtil.encrypt(key, String.valueOf(store.getMerchantId()));
				
			} else {
				this.setCountryCode(ctx.getCountryid());
			}

			/** Get some f the configurations **/
			MerchantService mservice = (MerchantService) ServiceFactory
					.getService(ServiceFactory.MerchantService);
			ConfigurationRequest req = new ConfigurationRequest(ctx
					.getMerchantid(), ConfigurationConstants.G_API);
			ConfigurationResponse resp = mservice.getConfiguration(req);

			MerchantConfiguration gCode = resp
					.getMerchantConfiguration(ConfigurationConstants.G_API);
			if (gCode != null
					&& !StringUtils.isBlank(gCode.getConfigurationValue1())) {
				ctx.setgCode(gCode.getConfigurationValue1());
			}

			this.showOrderSummary();

			switch (status) {

			case Constants.CENTRAL_STATUS_NEW:// first access, store profile not
												// yet created
				this.checkConfiguration();
				break;

			case Constants.CENTRAL_STATUS_REVOCATED:// revocated not implemented
				this.setStatusMessageCode(99);
				break;

			}
			


		} catch (Exception e) {
			log.error(e);
			MessageUtil.addErrorMessage(super.getServletRequest(), LabelUtil
					.getInstance().getText("errors.technical"));

		}

		return SUCCESS;
	}

	/**
	 * Logout action
	 * 
	 * @return
	 * @throws Exception
	 */
	public String logout() throws Exception {

		Locale locale = getLocale();
		String lang = locale.getLanguage();
		super.getServletRequest().setAttribute("lang", lang);
		return SUCCESS;
	}

	/**
	 * This is the entry point to the system
	 * 
	 * @return
	 * @throws Exception
	 */
	public String logon() throws Exception {

		try {

			// Logon script
			MerchantService service = (MerchantService) ServiceFactory
					.getService(ServiceFactory.MerchantService);
			userInformation = service.adminLogon(super.getServletRequest());

			// get MerchantUserRegistration
			MerchantRegistration registration = service
					.getMerchantRegistration(userInformation.getMerchantId());

			// get MerchantStore
			store = service.getMerchantStore(userInformation.getMerchantId());

			Context ctx = new Context();
			ctx.setMerchantid(userInformation.getMerchantId());
			ctx.setRegistrationCode(registration
					.getMerchantRegistrationDefCode());
			ctx.setPromoCode(new Integer(registration.getPromoCode()));
			if (!StringUtils.isBlank(userInformation.getUserlang())) {
				ctx.setLang(userInformation.getUserlang());
			} else {
				ctx.setLang(LanguageUtil.getDefaultLanguage());
			}

			if (store != null) {

				ctx.setCurrency(store.getCurrency());
				ctx.setSizeunit(store.getSeizeunitcode());
				ctx.setWeightunit(store.getWeightunitcode());
				LanguageHelper.setLanguages(store.getSupportedlanguages(), ctx);

				if (store.getCountry() == 0) {

					ctx.setCountryid(userInformation.getUsercountrycode());

				} else {

					ctx.setCountryid(store.getCountry());

				}

				if (StringUtils.isBlank(store.getZone())) {

					if (StringUtils.isNumeric(userInformation.getUserstate())) {
						ctx.setZoneid(Integer.parseInt(userInformation
								.getUserstate()));
					} else {
						ctx.setZoneid(0);
					}

				} else {

					if (StringUtils.isNumeric(store.getZone())) {
						ctx.setZoneid(Integer.parseInt(store.getZone()));
					} else {
						ctx.setZoneid(0);
					}
				}

				// set default values
				if (StringUtils.isBlank(store.getCurrency())) {
					ctx.setCurrency(Constants.CURRENCY_CODE_USD);
				}

				if (StringUtils.isBlank(store.getWeightunitcode())) {
					ctx.setWeightunit(Constants.LB_WEIGHT_UNIT);
				}

				if (StringUtils.isBlank(store.getSeizeunitcode())) {
					ctx.setWeightunit(Constants.INCH_SIZE_UNIT);
				}

			} else {

				ctx.setCountryid(Constants.US_COUNTRY_ID);
				ctx.setCurrency(Constants.CURRENCY_CODE_USD);
				ctx.setZoneid(0);
				ctx.setExistingStore(false);
			}

			// If country / zone not set, set default values of user until user
			// decides to
			// configure

			// end default settings

			// cleanup previous sessions object
			super.getServletRequest().getSession().removeAttribute(
					ProfileConstants.context);
			super.getServletRequest().getSession().setAttribute(
					ProfileConstants.merchant, userInformation.getMerchantId());
			super.getServletRequest().getSession().setAttribute(
					ProfileConstants.context, ctx);
			setAdminTokenToSession(userInformation.getMerchantId());

			RefCache cache = RefCache.getInstance();

			Map countries = cache.getAllcountriesmap(LanguageUtil
					.getLanguageNumberCode(ctx.getLang()));
			Country c = (Country) countries.get(ctx.getCountryid());

			Locale locale = new Locale(ctx.getLang(), c.getCountryIsoCode2());
			super.setLocale(locale);

			this.display();

		} catch (Throwable e) {

			super.getServletRequest().setAttribute("error_message",
					LabelUtil.getInstance().getText("errors.technical"));

			if (e instanceof ServiceException) {
				ServiceException se = (ServiceException) e;

				if (se.getReason() == ErrorConstants.INVALID_CREDENTIALS) {
					MessageUtil.addErrorMessage(super.getServletRequest(),
							LabelUtil.getInstance().getText(
									"errors.invalidcredentials"));
					super.getServletRequest().setAttribute(
							"error_message",
							LabelUtil.getInstance().getText(
									"errors.invalidcredentials"));
				} else {
					MessageUtil.addErrorMessage(super.getServletRequest(), "");
				}

			}

			MessageUtil.addErrorMessage(super.getServletRequest(), LabelUtil
					.getInstance().getText("messages.profilecreationerror"));
			log.error(e);
			return "CREDENTIALSERROR";
		}

		return SUCCESS;
	}

	public List getOrders() {
		return orders;
	}

	public List getCartCounters() {
		return cartCounters;
	}

	public String getCountryIsoCode() {
		return countryIsoCode;
	}

	public void setCountryIsoCode(String countryIsoCode) {
		this.countryIsoCode = countryIsoCode;
	}

	public boolean isZoneMapRegion() {
		return zoneMapRegion;
	}

	public void setZoneMapRegion(boolean zoneMapRegion) {
		this.zoneMapRegion = zoneMapRegion;
	}

	public int getZoneMapCount() {
		return zoneMapCount;
	}

	public void setZoneMapCount(int zoneMapCount) {
		this.zoneMapCount = zoneMapCount;
	}

	public Collection<ZoneMap> getZoneMaps() {
		return zoneMaps;
	}

	public void setZoneMaps(Collection<ZoneMap> zoneMaps) {
		this.zoneMaps = zoneMaps;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getConfigurationMessageTitle() {
		return configurationMessageTitle;
	}

	public void setConfigurationMessageTitle(String configurationMessageTitle) {
		this.configurationMessageTitle = configurationMessageTitle;
	}

	public Collection<String> getConfigurationMessages() {
		return configurationMessages;
	}

	public void setConfigurationMessages(
			Collection<String> configurationMessages) {
		this.configurationMessages = configurationMessages;
	}

	public int getStatusMessageCode() {
		return statusMessageCode;
	}

	public void setStatusMessageCode(int statusMessageCode) {
		this.statusMessageCode = statusMessageCode;
	}

	public MerchantStore getStore() {
		return store;
	}

	public void setStore(MerchantStore store) {
		this.store = store;
	}

	public MerchantUserInformation getUserInformation() {
		return userInformation;
	}

	public void setUserInformation(MerchantUserInformation userInformation) {
		this.userInformation = userInformation;
	}

	public String getApiKey() {
		return apiKey;
	}

	public void setApiKey(String apiKey) {
		this.apiKey = apiKey;
	}

}
