/*
 * Licensed to csti consulting 
 * You may obtain a copy of the License at
 *
 * http://www.csticonsulting.com
 * Copyright (c) 2006-Aug 24, 2010 Consultation CS-TI inc. 
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package com.salesmanager.core.util;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import org.apache.commons.configuration.Configuration;
import org.apache.commons.lang.StringUtils;

import com.salesmanager.core.constants.SecurityConstants;
import com.salesmanager.core.entity.customer.Customer;
import com.salesmanager.core.entity.merchant.MerchantStore;
import com.salesmanager.core.entity.orders.Order;
import com.salesmanager.core.service.ServiceFactory;
import com.salesmanager.core.service.merchant.MerchantService;

public class FileUtil {

	private final static String IMAGE_PATH = PropertiesUtil.getConfiguration()
			.getString("core.store.mediaurl", "http://localhost:8080/images");

	public enum ContentCategoryType {
		IMAGE, FLASH, INVALID, FILE
	}

	public static String getInvoiceUrl(Order order, Customer customer)
			throws Exception {

		Configuration conf = PropertiesUtil.getConfiguration();

		MerchantService mservice = (MerchantService) ServiceFactory
				.getService(ServiceFactory.MerchantService);
		MerchantStore store = mservice.getMerchantStore(order.getMerchantId());

		// ***build fileid***
		StringBuffer urlconstruct = new StringBuffer();
		StringBuffer invoiceurl = new StringBuffer();

		// order id and, expiration date and language
		urlconstruct.append(order.getOrderId()).append("|").append(
				customer.getCustomerId());

		String lang = conf.getString("core.system.defaultlanguage", "en");
		if (customer != null) {
			lang = customer.getCustomerLang();
		}

		String file = EncryptionUtil.encrypt(EncryptionUtil
				.generatekey(SecurityConstants.idConstant), urlconstruct
				.toString());

		invoiceurl.append(ReferenceUtil.buildCartUri(store)).append(
				conf.getString("core.salesmanager.core.viewInvoiceAction"))
				.append("?fileId=").append(file);

		return invoiceurl.toString();

	}

	public static String getOrderDownloadFileUrl(Order order, Customer customer)
			throws Exception {

		Configuration conf = PropertiesUtil.getConfiguration();

		MerchantService mservice = (MerchantService) ServiceFactory
				.getService(ServiceFactory.MerchantService);
		MerchantStore store = mservice.getMerchantStore(order.getMerchantId());

		// ***build fileid***
		StringBuffer urlconstruct = new StringBuffer();
		StringBuffer downloadurl = new StringBuffer();
		Calendar endDate = Calendar.getInstance();
		endDate.add(Calendar.DATE, conf.getInt(
				"core.product.file.downloadmaxdays", 2)); // add 2 days
		Date denddate = endDate.getTime();
		String sedate = DateUtil.formatDate(denddate);

		// order id and, expiration date and language
		urlconstruct.append(order.getOrderId()).append("|").append("|").append(
				sedate);

		String lang = conf.getString("core.system.defaultlanguage", "en");
		if (customer != null) {
			lang = customer.getCustomerLang();
		}

		String file = EncryptionUtil.encrypt(EncryptionUtil
				.generatekey(SecurityConstants.idConstant), urlconstruct
				.toString());

		downloadurl.append(ReferenceUtil.buildCheckoutUri(store)).append(
				conf.getString("core.salesmanager.core.viewFilesAction"))
				.append("?fileId=").append(file).append("&lang=").append(lang);

		return downloadurl.toString();

	}

	public static String getInternalDownloadFileUrl(int merchantId,
			long downloadId) throws Exception {

		Configuration conf = PropertiesUtil.getConfiguration();

		MerchantService mservice = (MerchantService) ServiceFactory
				.getService(ServiceFactory.MerchantService);
		MerchantStore store = mservice.getMerchantStore(merchantId);

		// ***build fileid***
		StringBuffer urlconstruct = new StringBuffer();
		StringBuffer downloadurl = new StringBuffer();
		Calendar endDate = Calendar.getInstance();
		endDate.add(Calendar.DATE, conf.getInt(
				"core.product.file.downloadmaxdays", 2)); // add 2 days
		Date denddate = endDate.getTime();
		String sedate = DateUtil.formatDate(denddate);

		urlconstruct.append(downloadId).append("|").append(sedate).append("|")
				.append(merchantId);

		String file = EncryptionUtil.encrypt(EncryptionUtil
				.generatekey(SecurityConstants.idConstant), urlconstruct
				.toString());

		downloadurl.append(ReferenceUtil.buildCheckoutUri(store)).append(
				conf.getString("core.salesmanager.core.downloadFileAction"))
				.append("?fileId=").append(file).append("&mod=productfile");

		return downloadurl.toString();

	}

	/**
	 * Decrypt & Parses a url with tokens for displaying invoice page
	 * 
	 * @param token
	 * @return
	 * @throws Exception
	 */
	public static Map<String, String> getInvoiceTokens(String token)
			throws Exception {

		if (StringUtils.isBlank(token)) {
			throw new Exception("token (url parameter) is empty");
		}

		String decrypted = EncryptionUtil.decrypt(EncryptionUtil
				.generatekey(SecurityConstants.idConstant), token);

		StringTokenizer st = new StringTokenizer(decrypted, "|");
		String orderId = "";
		String customerId = "";

		int i = 0;
		while (st.hasMoreTokens()) {
			String t = st.nextToken();
			if (i == 0) {
				orderId = t;
			} else if (i == 1) {
				customerId = t;
			} else {
				break;
			}
			i++;
		}

		if (StringUtils.isBlank(orderId) || StringUtils.isBlank(customerId)) {
			throw new Exception("Invalid URL parameters for getInvoiceTokens "
					+ token);
		}

		Map response = new HashMap();
		response.put("order.orderId", orderId);
		response.put("customer.customerId", customerId);

		return response;
	}

	/**
	 * Decrypt & Parses a url with tokens for displaying order page
	 * 
	 * @param tokens
	 * @return
	 * @throws Exception
	 */
	public static Map<String, String> getOrderDownloadFileTokens(String token)
			throws Exception {

		String decrypted = EncryptionUtil.decrypt(EncryptionUtil
				.generatekey(SecurityConstants.idConstant), token);

		StringTokenizer st = new StringTokenizer(decrypted, "|");
		String orderId = "";
		String date = "";

		int i = 0;
		while (st.hasMoreTokens()) {
			String t = st.nextToken();
			if (i == 0) {
				orderId = t;
			} else if (i == 1) {
				date = t;
			} else {
				break;
			}
			i++;
		}

		if (StringUtils.isBlank(orderId) || StringUtils.isBlank(date)) {
			throw new Exception(
					"Invalid URL parameters for FileUtil.getOrderDownloadFileTokens "
							+ token);
		}

		Map response = new HashMap();
		response.put("ID", orderId);
		response.put("DATE", date);

		return response;
	}

	/**
	 * Decrypt and parses file token
	 * 
	 * @param tokens
	 * @return
	 * @throws Exception
	 */
	public static Map<String, String> getFileDownloadFileTokens(String token)
			throws Exception {

		String decrypted = EncryptionUtil.decrypt(EncryptionUtil
				.generatekey(SecurityConstants.idConstant), token);

		StringTokenizer st = new StringTokenizer(decrypted, "|");
		String downloadId = "";
		String date = "";
		String merchantId = "";

		int i = 0;
		while (st.hasMoreTokens()) {
			String t = st.nextToken();
			if (i == 0) {
				downloadId = t;
			} else if (i == 1) {
				date = t;
			} else if (i == 2) {
				merchantId = t;
			} else {
				break;
			}
			i++;
		}

		if (StringUtils.isBlank(downloadId) || StringUtils.isBlank(date)
				|| StringUtils.isBlank(merchantId)) {
			throw new Exception(
					"Invalid URL parameters for FileUtil.getFileDownloadFileTokens "
							+ token);
		}

		Map response = new HashMap();
		response.put("ID", downloadId);
		response.put("DATE", date);
		response.put("MERCHANTID", merchantId);

		return response;

	}

	public static String getStoreLogoPath(int merchantId, String storeLogo) {

		/*
		 * StringBuffer imagePath = new StringBuffer();
		 * if(!IMAGE_PATH.contains("http://")) {
		 * imagePath.append(req.getContextPath()).append(IMAGE_PATH); } else {
		 * imagePath.append(IMAGE_PATH); }
		 */

		Configuration config = PropertiesUtil.getConfiguration();
		return new StringBuffer().append(IMAGE_PATH).append(
				config.getString("core.store.brandingsuri")).append(merchantId)
				.append("/header/").append(storeLogo).toString();

	}

	public static String getStoreBannerPath(int merchantId, String storeBanner) {

		/*
		 * StringBuffer imagePath = new StringBuffer();
		 * if(!IMAGE_PATH.contains("http://")) {
		 * imagePath.append(req.getContextPath()).append(IMAGE_PATH); } else {
		 * imagePath.append(IMAGE_PATH); }
		 */

		Configuration config = PropertiesUtil.getConfiguration();
		return new StringBuffer().append(IMAGE_PATH).append(
				config.getString("core.store.brandingsuri")).append(merchantId)
				.append("/banner/").append(storeBanner).toString();
	}

	public static String getLargeProductImagePath(int merchantId,
			String productImage) {
		if (StringUtils.isBlank(productImage)) {
			return "";
		} else {

			Configuration config = PropertiesUtil.getConfiguration();
			/*
			 * StringBuffer imagePath = new StringBuffer();
			 * if(!IMAGE_PATH.contains("http://")) {
			 * imagePath.append(req.getContextPath()).append(IMAGE_PATH); } else
			 * { imagePath.append(IMAGE_PATH); }
			 */

			return new StringBuffer()
					.append(IMAGE_PATH)
					.append(config.getString("core.products.images.uri"))
					.append("/")
					.append(merchantId)
					.append("/")
					.append(config.getString("core.product.image.large.prefix"))
					.append("-").append(productImage).toString();
		}
	}

	public static String getSmallProductImagePath(int merchantId,
			String productImage) {

		/*
		 * StringBuffer imagePath = new StringBuffer();
		 * if(!IMAGE_PATH.contains("http://")) {
		 * imagePath.append(req.getContextPath()).append(IMAGE_PATH); } else {
		 * imagePath.append(IMAGE_PATH); }
		 */

		if (StringUtils.isBlank(productImage)) {
			return "";
		} else {
			Configuration config = PropertiesUtil.getConfiguration();
			return new StringBuffer()
					.append(IMAGE_PATH)
					.append(config.getString("core.products.images.uri"))
					.append("/")
					.append(merchantId)
					.append("/")
					.append(config.getString("core.product.image.small.prefix"))
					.append("-").append(productImage).toString();
		}
	}

	/**
	 * returns original image
	 * 
	 * @param merchantId
	 * @param productImage
	 * @return
	 */
	public static String getProductImagePath(int merchantId, String productImage) {
		if (StringUtils.isBlank(productImage)) {
			return "";
		} else {

			/*
			 * StringBuffer imagePath = new StringBuffer();
			 * if(!IMAGE_PATH.contains("http://")) {
			 * imagePath.append(req.getContextPath()).append(IMAGE_PATH); } else
			 * { imagePath.append(IMAGE_PATH); }
			 */

			Configuration config = PropertiesUtil.getConfiguration();
			return new StringBuffer().append(IMAGE_PATH).append(
					config.getString("core.products.images.uri")).append("/")
					.append(merchantId).append("/").append(productImage)
					.toString();
		}
	}

	/**
	 * getBinPath returns the Path to the bin folder of the merchant(specific to
	 * merchantId) and also according to the type i.e. if isImage is true then
	 * it gives the image path of that particular merchant else it gives the
	 * shock-wave path.
	 * 
	 * @param merchantId
	 *            int
	 * @param isImage
	 *            boolean
	 * @return String path
	 */
	public static String getBinPath(int merchantId, boolean isImage) {
		Configuration config = PropertiesUtil.getConfiguration();
		StringBuilder builder = new StringBuilder().append(config
				.getString("core.bin.filefolder"));
		builder.append("/").append((isImage ? "images" : "flash")).append("/")
				.append(merchantId);
		return builder.toString();
	}

	public static String getBinPath() {
		Configuration config = PropertiesUtil.getConfiguration();
		StringBuilder builder = new StringBuilder().append(config
				.getString("core.bin.filefolder"));
		return builder.toString();
	}

	public static String getFileTreeBinPath() {
		Configuration config = PropertiesUtil.getConfiguration();
		StringBuilder builder = new StringBuilder().append(config
				.getString("core.bin.filetree.filefolder"));
		return builder.toString();
	}

	public static String getFileTreeBinPath(int merchantId, boolean isImage) {
		StringBuilder builder = new StringBuilder();
		builder.append(getFileTreeBinPath()).append("/").append(
				(isImage ? "images" : "flash")).append("/").append(merchantId)
				.append("/");
		return builder.toString();
	}

	public static String getBinServerUrl() {
		Configuration config = PropertiesUtil.getConfiguration();
		StringBuilder builder = new StringBuilder().append(IMAGE_PATH).append(
				config.getString("core.bin.uri")).append("/");
		return builder.toString();
	}

	public static String getBinServerUrl(int merchantId, boolean isImage) {
		Configuration config = PropertiesUtil.getConfiguration();
		StringBuilder builder = new StringBuilder().append(IMAGE_PATH).append(
				config.getString("core.bin.uri")).append("/").append(
				(isImage ? "images" : "flash")).append("/").append(merchantId)
				.append("/");
		return builder.toString();
	}

	public static ContentCategoryType getContentCategoryType(
			String fileContentType) {
		Configuration config = PropertiesUtil.getConfiguration();
		String imageContentTypes = config
				.getString("core.bin.images.contenttypes");
		String flashContentType = config.getString("core.shockwaveformat");
		String filesContentType = config
				.getString("core.bin.files.contenttypes");
		if (fileContentType == null || fileContentType.trim() == "") {
			return ContentCategoryType.INVALID;
		}
		if (imageContentTypes.toLowerCase().contains(
				fileContentType.toLowerCase())) {
			return ContentCategoryType.IMAGE;
		} else if (flashContentType.toLowerCase().equals(
				fileContentType.toLowerCase())) {
			return ContentCategoryType.FLASH;
		} else if (filesContentType.toLowerCase().contains(
				filesContentType.toLowerCase())) {
			return ContentCategoryType.FILE;
		} else {
			return ContentCategoryType.INVALID;
		}
	}

}
