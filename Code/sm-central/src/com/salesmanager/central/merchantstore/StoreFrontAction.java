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
package com.salesmanager.central.merchantstore;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.salesmanager.central.BaseAction;
import com.salesmanager.central.profile.Context;
import com.salesmanager.core.constants.CatalogConstants;
import com.salesmanager.core.constants.ConfigurationConstants;
import com.salesmanager.core.constants.LabelConstants;
import com.salesmanager.core.entity.merchant.MerchantConfiguration;
import com.salesmanager.core.entity.merchant.MerchantStore;
import com.salesmanager.core.entity.reference.CoreModuleService;
import com.salesmanager.core.entity.reference.DynamicLabel;
import com.salesmanager.core.entity.reference.DynamicLabelDescription;
import com.salesmanager.core.entity.reference.DynamicLabelDescriptionId;
import com.salesmanager.core.service.ServiceFactory;
import com.salesmanager.core.service.merchant.ConfigurationRequest;
import com.salesmanager.core.service.merchant.ConfigurationResponse;
import com.salesmanager.core.service.merchant.MerchantService;
import com.salesmanager.core.service.reference.ReferenceService;
import com.salesmanager.core.util.CountryUtil;
import com.salesmanager.core.util.LabelUtil;

public class StoreFrontAction extends BaseAction {

	private Logger log = Logger.getLogger(StoreFrontAction.class);
	private Collection templates = new ArrayList();// store front templates

	private CoreModuleService currrentTempate = null;

	private List<String> storeDescription = new ArrayList<String>();// store
																	// text
																	// submited
	private List<String> pageTitle = new ArrayList<String>();// text submited

	private List<String> metaKeywords = new ArrayList<String>();// text submited
	private List<String> metaDescription = new ArrayList<String>();// text
																	// submited

	private MerchantConfiguration googleCode = null;
	private String analytics = null;
	private String api;

	public String getAnalytics() {
		return analytics;
	}

	public void setAnalytics(String analytics) {
		this.analytics = analytics;
	}

	private void prepareContent() throws Exception {

		Context ctx = super.getContext();

		String countryCode = CountryUtil.getCountryIsoCodeById(ctx
				.getCountryid());

		ReferenceService rservice = (ReferenceService) ServiceFactory
				.getService(ServiceFactory.ReferenceService);
		templates = rservice.getCoreModules(
				CatalogConstants.STORE_FRONT_TEMPLATES_CODE, countryCode);

		// overwrite name
		if (templates != null && templates.size() > 0) {
			Iterator i = templates.iterator();
			while (i.hasNext()) {
				CoreModuleService cms = (CoreModuleService) i.next();
				try {
					String title = LabelUtil.getInstance().getText(
							ctx.getLang(),
							"module." + cms.getCoreModuleName() + ".title");
					cms.setCoreModuleServiceDescription(title);
				} catch (Exception e) {
					log.error(e);
				}
			}
		}

		MerchantService mservice = (MerchantService) ServiceFactory
				.getService(ServiceFactory.MerchantService);
		// get current template
		MerchantStore store = mservice.getMerchantStore(ctx.getMerchantid());

		String templateModule = store.getTemplateModule();
		// selected
		if (!StringUtils.isBlank(templateModule)) {

			currrentTempate = rservice.getCoreModuleService(ctx.getLang(),
					templateModule);
			// String title = LabelUtil.getInstance().getText(ctx.getLang(),
			// "module." + templateModule + ".title");
			if (currrentTempate != null) {
				currrentTempate.setCoreModuleServiceDescription(templateModule);
			}

		}

		// get analytics
		ConfigurationRequest req = new ConfigurationRequest(
				ctx.getMerchantid(), ConfigurationConstants.G_API);
		ConfigurationResponse resp = mservice.getConfiguration(req);

		googleCode = resp
				.getMerchantConfiguration(ConfigurationConstants.G_API);

		Collection<DynamicLabel> dynamicLabels = rservice
				.getDynamicLabels(super.getContext().getMerchantid().intValue());

		if (dynamicLabels != null && dynamicLabels.size() > 0) {

			Iterator i = dynamicLabels.iterator();

			while (i.hasNext()) {

				DynamicLabel dl = (DynamicLabel) i.next();

				Set dynamicLabelSet = dl.getDescriptions();
				Iterator labelSetIterator = dynamicLabelSet.iterator();

				if (dl.getSectionId() == LabelConstants.STORE_FRONT_LANDING_DESCRIPTION) {

					Map labelMap = new HashMap();

					while (labelSetIterator.hasNext()) {
						DynamicLabelDescription description = (DynamicLabelDescription) labelSetIterator
								.next();
						labelMap.put(description.getId().getLanguageId(),
								description);
					}

					for (int icount = 0; icount < reflanguages.size(); icount++) {
						int langid = (Integer) reflanguages.get(icount);
						DynamicLabelDescription desc = (DynamicLabelDescription) labelMap
								.get(langid);
						if (desc != null) {
							storeDescription.add(desc
									.getDynamicLabelDescription());
						}
					}

				}

				else if (dl.getSectionId() == LabelConstants.STORE_FRONT_LANDING_PAGE_TITLE) {

					Map labelMap = new HashMap();

					while (labelSetIterator.hasNext()) {
						DynamicLabelDescription description = (DynamicLabelDescription) labelSetIterator
								.next();
						labelMap.put(description.getId().getLanguageId(),
								description);
					}

					for (int icount = 0; icount < reflanguages.size(); icount++) {
						int langid = (Integer) reflanguages.get(icount);
						DynamicLabelDescription desc = (DynamicLabelDescription) labelMap
								.get(langid);
						if (desc != null) {
							pageTitle.add(desc.getDynamicLabelDescription());
						}
					}

				}

				if (dl.getSectionId() == LabelConstants.STORE_FRONT_LANDING_META_KEYWORDS) {

					Map labelMap = new HashMap();

					while (labelSetIterator.hasNext()) {
						DynamicLabelDescription description = (DynamicLabelDescription) labelSetIterator
								.next();
						labelMap.put(description.getId().getLanguageId(),
								description);
					}

					for (int icount = 0; icount < reflanguages.size(); icount++) {
						int langid = (Integer) reflanguages.get(icount);
						DynamicLabelDescription desc = (DynamicLabelDescription) labelMap
								.get(langid);
						if (desc != null) {
							metaKeywords.add(desc.getDynamicLabelDescription());
						}
					}

				}

				if (dl.getSectionId() == LabelConstants.STORE_FRONT_LANDING_META_DESCRIPTION) {

					Map labelMap = new HashMap();

					while (labelSetIterator.hasNext()) {
						DynamicLabelDescription description = (DynamicLabelDescription) labelSetIterator
								.next();
						labelMap.put(description.getId().getLanguageId(),
								description);
					}

					for (int icount = 0; icount < reflanguages.size(); icount++) {
						int langid = (Integer) reflanguages.get(icount);
						DynamicLabelDescription desc = (DynamicLabelDescription) labelMap
								.get(langid);
						if (desc != null) {
							metaDescription.add(desc
									.getDynamicLabelDescription());
						}
					}

				}

			}

		}

	}

	/**
	 * Displays the page allowing basic store front configuration
	 * 
	 * @return
	 */
	public String displayStoreFrontConfig() {

		try {

			Context ctx = super.getContext();

			prepareLanguages();

			prepareContent();

			if (googleCode != null) {
				analytics = googleCode.getConfigurationValue();
				api = googleCode.getConfigurationValue1();
			}

		} catch (Exception e) {
			log.error(e);
		}
		return SUCCESS;

	}

	public String editStoreFontConfig() {

		try {

			prepareLanguages();

			prepareContent();

			Context ctx = super.getContext();

			if (this.reflanguages.size() == 0) {
				log.error("Languages were not loaded");
				super.setTechnicalMessage();
				return INPUT;
			}

			// retreive current values
			ReferenceService rservice = (ReferenceService) ServiceFactory
					.getService(ServiceFactory.ReferenceService);
			Collection<DynamicLabel> dynamicLabels = rservice
					.getDynamicLabels(super.getContext().getMerchantid()
							.intValue());

			MerchantService mservice = (MerchantService) ServiceFactory
					.getService(ServiceFactory.MerchantService);

			Map submited = new HashMap();

			if (this.getStoreDescription().size() > 0) {
				submited.put(LabelConstants.STORE_FRONT_LANDING_DESCRIPTION,
						this.getStoreDescription());
			}

			if (this.getPageTitle().size() > 0) {
				submited.put(LabelConstants.STORE_FRONT_LANDING_PAGE_TITLE,
						this.getPageTitle());
			}

			if (this.getMetaKeywords().size() > 0) {
				submited.put(LabelConstants.STORE_FRONT_LANDING_META_KEYWORDS,
						this.getMetaKeywords());
			}

			if (this.getMetaDescription().size() > 0) {
				submited.put(
						LabelConstants.STORE_FRONT_LANDING_META_DESCRIPTION,
						this.getMetaDescription());
			}

			if (dynamicLabels != null && dynamicLabels.size() > 0) {

				Collection removable = new ArrayList();

				Iterator i = dynamicLabels.iterator();

				while (i.hasNext()) {

					DynamicLabel dl = (DynamicLabel) i.next();
					if (dl.getSectionId() == LabelConstants.STORE_FRONT_LANDING_DESCRIPTION) {
						removable.add(dl);
					}

					else if (dl.getSectionId() == LabelConstants.STORE_FRONT_LANDING_PAGE_TITLE) {
						removable.add(dl);
					}

					if (dl.getSectionId() == LabelConstants.STORE_FRONT_LANDING_META_KEYWORDS) {
						removable.add(dl);
					}

					if (dl.getSectionId() == LabelConstants.STORE_FRONT_LANDING_META_DESCRIPTION) {
						removable.add(dl);
					}

				}

				rservice.deleteAllDynamicLabel(removable);
			}

			Map newLabels = new HashMap();

			Map elements = new HashMap();

			Iterator submitedIterator = submited.keySet().iterator();
			while (submitedIterator.hasNext()) {
				int section = (Integer) submitedIterator.next();

				List valuesSubmited = (List) submited.get(section);

				Iterator valuesSubmitedIterator = valuesSubmited.iterator();

				Iterator i = reflanguages.keySet().iterator();
				while (i.hasNext()) {
					int langcount = (Integer) i.next();

					String desc = (String) valuesSubmited.get(langcount);

					// if not blank
					if (!StringUtils.isBlank(desc)) {

						DynamicLabel label = null;

						int submitedlangid = (Integer) reflanguages
								.get(langcount);

						if (!newLabels.containsKey(section)) {
							label = new DynamicLabel();
							newLabels.put(section, label);
						} else {
							label = (DynamicLabel) newLabels.get(section);
						}
						// create
						DynamicLabelDescriptionId id = new DynamicLabelDescriptionId();
						id.setLanguageId(submitedlangid);

						DynamicLabelDescription description = new DynamicLabelDescription();
						description.setId(id);
						description.setDynamicLabelDescription(desc);
						description.setDynamicLabelTitle(" ");

						Set descs = label.getDescriptions();
						if (descs == null) {
							descs = new HashSet();
						}

						descs.add(description);

						label.setMerchantId(ctx.getMerchantid());
						label.setSectionId(section);
						label.setDescriptions(descs);

					}

				}

			}

			// analytics
			if (!StringUtils.isBlank(analytics) || !StringUtils.isBlank(api)) {
				if (googleCode == null) {
					googleCode = new MerchantConfiguration();
					googleCode
							.setConfigurationKey(ConfigurationConstants.G_API);
					googleCode.setMerchantId(ctx.getMerchantid());
					googleCode.setDateAdded(new Date());
					googleCode.setLastModified(new Date());

				}
				if (!StringUtils.isBlank(analytics)) {
					googleCode.setConfigurationValue(analytics);
				}

				if (!StringUtils.isBlank(api)) {
					googleCode.setConfigurationValue1(api);
					ctx.setgCode(api);

				}

				mservice.saveOrUpdateMerchantConfiguration(googleCode);
			} else if (StringUtils.isBlank(analytics)
					&& !StringUtils.isBlank(api)) {

				if (googleCode != null) {
					ctx.setgCode(null);
					mservice.deleteMerchantConfiguration(googleCode);
				}
			}

			rservice.saveDynamicLabel(newLabels.values());
			super.setSuccessMessage();

			return SUCCESS;

		} catch (Exception e) {
			log.error(e);
			super.setTechnicalMessage();
			return INPUT;
		}

	}

	public Collection getTemplates() {
		return templates;
	}

	public void setTemplates(Collection templates) {
		this.templates = templates;
	}

	public CoreModuleService getCurrrentTempate() {
		return currrentTempate;
	}

	public void setCurrrentTempate(CoreModuleService currrentTempate) {
		this.currrentTempate = currrentTempate;
	}

	public List<String> getMetaDescription() {
		return metaDescription;
	}

	public void setMetaDescription(List<String> metaDescription) {
		this.metaDescription = metaDescription;
	}

	public List<String> getMetaKeywords() {
		return metaKeywords;
	}

	public void setMetaKeywords(List<String> metaKeywords) {
		this.metaKeywords = metaKeywords;
	}

	public List<String> getPageTitle() {
		return pageTitle;
	}

	public void setPageTitle(List<String> pageTitle) {
		this.pageTitle = pageTitle;
	}

	public List<String> getStoreDescription() {
		return storeDescription;
	}

	public void setStoreDescription(List<String> storeDescription) {
		this.storeDescription = storeDescription;
	}

	public String getApi() {
		return api;
	}

	public void setApi(String api) {
		this.api = api;
	}

}
