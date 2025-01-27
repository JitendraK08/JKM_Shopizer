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

import java.util.Locale;
import java.util.Map;

import org.apache.commons.configuration.Configuration;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.exception.ConstraintViolationException;

import com.salesmanager.central.CountrySelectBaseAction;
import com.salesmanager.core.constants.Constants;
import com.salesmanager.core.constants.SecurityConstants;
import com.salesmanager.core.entity.merchant.MerchantUserInformation;
import com.salesmanager.core.entity.reference.Country;
import com.salesmanager.core.service.ServiceFactory;
import com.salesmanager.core.service.cache.RefCache;
import com.salesmanager.core.service.merchant.MerchantService;
import com.salesmanager.core.util.EncryptionUtil;
import com.salesmanager.core.util.LabelUtil;
import com.salesmanager.core.util.LanguageUtil;
import com.salesmanager.core.util.MessageUtil;
import com.salesmanager.core.util.PropertiesUtil;

/**
 * Manage User Profile
 * 
 * @author Carl Samson
 * 
 */
public class ProfileAction extends CountrySelectBaseAction {

	private Logger log = Logger.getLogger(ProfileAction.class);

	private MerchantUserInformation merchantProfile;
	private Integer countryCode;
	private String ccMonth;
	private String ccYear;
	private String securityCode;

	private String newPassword;
	private String repeatNewPassword;

	public String changeLanguage() {

		Context context = super.getContext();

		String language = super.getServletRequest().getParameter("lang");
		if (!StringUtils.isBlank(language)) {

			RefCache cache = RefCache.getInstance();

			Map countries = cache.getAllcountriesmap(LanguageUtil
					.getLanguageNumberCode(context.getLang()));
			Country c = (Country) countries.get(context.getCountryid());

			Locale locale = new Locale(language, c.getCountryIsoCode2());
			super.setLocale(locale);
			
			Context ctx = super.getContext();
			ctx.setLang(locale.getLanguage());
			
		}

		return SUCCESS;

	}

	public String displayPassword() {

		try {

			int merchantId = super.getContext().getMerchantid();
			String user = super.getPrincipal().getRemoteUser();

			MerchantService mservice = (MerchantService) ServiceFactory
					.getService(ServiceFactory.MerchantService);

			merchantProfile = mservice.getMerchantUserInformation(user);

		} catch (Exception e) {
			log.error(e);
		}

		return SUCCESS;

	}

	public String changePassword() {

		try {

			if (merchantProfile == null) {
				log.error("merchantProfileIsNull");
				super.setTechnicalMessage();
				return INPUT;
			}

			int merchantId = super.getContext().getMerchantid();
			String user = super.getPrincipal().getRemoteUser();

			MerchantService mservice = (MerchantService) ServiceFactory
					.getService(ServiceFactory.MerchantService);

			MerchantUserInformation profile = mservice
					.getMerchantUserInformation(user);

			// new paswords match
			if (StringUtils.isBlank(merchantProfile.getAdminPass())) {
				super.setErrorMessage("messages.required.currentpassword");
				return INPUT;
			}

			if (StringUtils.isBlank(this.getNewPassword())) {
				super.setErrorMessage("messages.required.newpassword");
				return INPUT;
			}

			if (StringUtils.isBlank(this.getRepeatNewPassword())) {
				super.setErrorMessage("messages.required.repeatnewpassword");
				return INPUT;
			}

			if (!this.getNewPassword().equals(this.getRepeatNewPassword())) {
				super.setErrorMessage("messages.password.match");
				return INPUT;
			}

			// 6 to 8 characters
			if (this.getNewPassword().length() < 6
					|| this.getNewPassword().length() > 8) {
				super.setErrorMessage("messages.password.length");
				return INPUT;
			}

			String key = EncryptionUtil.generatekey(String
					.valueOf(SecurityConstants.idConstant));
			String enc = EncryptionUtil.encrypt(key, this.getNewPassword());

			profile.setAdminPass(enc);

			mservice.saveOrUpdateMerchantUserInformation(profile);

			super.setSuccessMessage();

		} catch (Exception e) {
			log.error(e);
			super.setTechnicalMessage();
			return INPUT;
		}

		return SUCCESS;

	}

	public String display() {

		// MerchantProfile profile = null;

		try {

			MerchantService mservice = (MerchantService) ServiceFactory
					.getService(ServiceFactory.MerchantService);

			merchantProfile = mservice.getMerchantUserInformation(super
					.getPrincipal().getUserPrincipal().getName());
			if (merchantProfile == null) {// should be created from the original
											// subscribtion process
				log.error("Profile does not exist for merchantid "
						+ super.getPrincipal().getRemoteUser());
				MessageUtil.addErrorMessage(super.getServletRequest(),
						LabelUtil.getInstance().getText("errors.technical"));
				return ERROR;
			}

			// NEED TO SET COUNTRY ID IN THE SESSION IN ORDER TO RETREIVE
			// ASSOCIATE PROVINCES
			if (merchantProfile.getUsercountrycode() == 0) {// original default
															// country code
				Configuration conf = PropertiesUtil.getConfiguration();
				int defaultCountry = conf
						.getInt("core.system.defaultcountryid",
								Constants.US_COUNTRY_ID);
				MessageUtil.addNoticeMessage(super.getServletRequest(),
						LabelUtil.getInstance().getText(
								"messages.updateinformation"));
				merchantProfile.setUsercountrycode(defaultCountry);
				super.prepareSelections(defaultCountry);
				// this.getServletRequest().getSession()
				// .setAttribute("COUNTRY", Constants.US_COUNTRY_ID);//force to
				// USA
			} else {
				// this.getServletRequest().getSession()
				// .setAttribute("COUNTRY", new
				// Integer(merchantProfile.getUsercountrycode()));
				super.prepareSelections(merchantProfile.getUsercountrycode());
			}

			/**
			 * //@todo get credit card //parse expiration date to mm yy format
			 * String ccDate = profile.getCcExpires(); if(ccDate!=null &&
			 * !ccDate.equals("")) { int length = ccDate.length(); String ccm =
			 * null; String ccy = null; if(length==4) { ccm =
			 * ccDate.substring(0,2); ccy = ccDate.substring(3); } else { ccm =
			 * "0" + ccDate.substring(0,1); ccy = ccDate.substring(2); }
			 * this.setCcYear(ccy); this.setCcMonth(ccm);
			 * 
			 * this.setSecurityCode(new String(profile.getCcCvv())); } else {
			 * java.util.Calendar cal = new java.util.GregorianCalendar();
			 * this.setCcYear
			 * (String.valueOf((cal.get(java.util.Calendar.YEAR))));
			 * this.setCcMonth
			 * (String.valueOf((cal.get(java.util.Calendar.MONTH))));
			 * this.setSecurityCode(""); }
			 * 
			 * 
			 * if(profile.getCcNumber()!=null &&
			 * !profile.getCcNumber().trim().equals("")) { //decrypt credit card
			 * String decryptedvalue =
			 * EncryptionUtil.decrypt(EncryptionUtil.generatekey
			 * (String.valueOf(merchantid.intValue())), profile.getCcNumber());
			 * //mask value CreditCardUtil util = new CreditCardUtil(); String
			 * card = util.maskCardNumber(decryptedvalue);
			 * profile.setCcNumber(card); }
			 **/

			// }

		} catch (Exception e) {
			MessageUtil.addErrorMessage(super.getServletRequest(), LabelUtil
					.getInstance().getText("errors.technical"));
			log.error(e);
		}

		return SUCCESS;

	}

	/**
	 * saveProfile
	 * 
	 * @return "SUCCESS" or "ERROR"
	 * @throws Exception
	 */
	public String saveProfile() throws Exception {


		try {


			MerchantService mservice = (MerchantService) ServiceFactory
					.getService(ServiceFactory.MerchantService);

			Context ctx = (Context) super.getServletRequest().getSession()
					.getAttribute(ProfileConstants.context);
			Integer merchantid = ctx.getMerchantid();

			MerchantUserInformation mUserInfo = mservice
					.getMerchantUserInformation(super.getPrincipal()
							.getRemoteUser());

			if (mUserInfo == null) {
				mUserInfo = new MerchantUserInformation();
			}



			java.util.Date dt = new java.util.Date();

			mUserInfo.setAdminEmail(this.merchantProfile.getAdminEmail());
			mUserInfo.setUserfname(this.merchantProfile.getUserfname());
			mUserInfo.setUserlname(this.merchantProfile.getUserlname());
			mUserInfo.setUseraddress(this.merchantProfile.getUseraddress());
			mUserInfo.setUsercity(this.merchantProfile.getUsercity());
			mUserInfo.setUserphone(this.merchantProfile.getUserphone());
			mUserInfo.setUserpostalcode(this.merchantProfile
					.getUserpostalcode());
			mUserInfo.setUserstate(this.merchantProfile.getUserstate());
			mUserInfo.setUsercountrycode(this.merchantProfile
					.getUsercountrycode());
			mUserInfo.setUserlang(this.merchantProfile.getUserlang());

			super.prepareSelections(mUserInfo.getUsercountrycode());

			mUserInfo.setLastModified(new java.util.Date(dt.getTime()));

			mservice.saveOrUpdateMerchantUserInformation(mUserInfo);


			ctx.setLang(mUserInfo.getUserlang());


			super.setSuccessMessage();

		} catch (Exception e) {

			if (e instanceof ConstraintViolationException) {
				MessageUtil.addErrorMessage(super.getServletRequest(),
						LabelUtil.getInstance().getText(
								"messages.emailalreadyexist"));
			} else {
				log.error(e);
				MessageUtil.addErrorMessage(super.getServletRequest(),
						LabelUtil.getInstance().getText("errors.technical"));
			}
		}

		return SUCCESS;

	}

	public MerchantUserInformation getMerchantProfile() {
		return merchantProfile;
	}

	public void setMerchantProfile(MerchantUserInformation merchantProfile) {
		this.merchantProfile = merchantProfile;
	}

	public Integer getCountryCode() {
		return countryCode;
	}

	public void setCountryCode(Integer countryCode) {
		this.countryCode = countryCode;
	}

	public String getCcMonth() {
		return ccMonth;
	}

	public void setCcMonth(String ccMonth) {
		this.ccMonth = ccMonth;
	}

	public String getCcYear() {
		return ccYear;
	}

	public void setCcYear(String ccYear) {
		this.ccYear = ccYear;
	}

	public String getSecurityCode() {
		return securityCode;
	}

	public void setSecurityCode(String securityCode) {
		this.securityCode = securityCode;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public String getRepeatNewPassword() {
		return repeatNewPassword;
	}

	public void setRepeatNewPassword(String repeatNewPassword) {
		this.repeatNewPassword = repeatNewPassword;
	}

}
