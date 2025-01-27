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
package com.salesmanager.central.util.store;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import uk.ltd.getahead.dwr.WebContextFactory;

import com.salesmanager.central.profile.Context;
import com.salesmanager.central.profile.ProfileConstants;
import com.salesmanager.core.entity.merchant.MerchantStore;
import com.salesmanager.core.entity.reference.CoreModuleService;
import com.salesmanager.core.service.ServiceFactory;
import com.salesmanager.core.service.merchant.MerchantService;
import com.salesmanager.core.service.reference.ReferenceService;
import com.salesmanager.core.util.LabelUtil;

public class StoreFront {

	private Logger log = Logger.getLogger(StoreFront.class);

	public CoreModuleService selectTemplate(String moduleName,
			String countryCode) {

		try {

			HttpServletRequest req = WebContextFactory.get()
					.getHttpServletRequest();

			// get context
			Context ctx = (Context) req.getSession().getAttribute(
					ProfileConstants.context);

			// get actual template

			MerchantService mservice = (MerchantService) ServiceFactory
					.getService(ServiceFactory.MerchantService);
			MerchantStore store = mservice
					.getMerchantStore(ctx.getMerchantid());

			store.setTemplateModule(moduleName);
			mservice.saveOrUpdateMerchantStore(store);

			ReferenceService rservice = (ReferenceService) ServiceFactory
					.getService(ServiceFactory.ReferenceService);
			CoreModuleService service = rservice.getCoreModuleService(
					countryCode, moduleName);

			String title = LabelUtil.getInstance().getText(ctx.getLang(),
					"module." + moduleName + ".title");

			service.setCoreModuleServiceDescription(title);

			return service;

		} catch (Exception e) {
			log.error(e);
			return null;
		}

	}

}
