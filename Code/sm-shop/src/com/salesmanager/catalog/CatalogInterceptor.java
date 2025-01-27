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
package com.salesmanager.catalog;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionInvocation;
import com.salesmanager.common.ShopInterceptor;
import com.salesmanager.core.util.ReferenceUtil;
import com.salesmanager.core.util.www.BaseActionAware;

/**
 * Information on the store, request parameters, Locale
 * 
 * @author Carl Samson
 * 
 */
public class CatalogInterceptor extends ShopInterceptor {

	private static Logger log = Logger.getLogger(CatalogInterceptor.class);

	@Override
	protected String doIntercept(ActionInvocation invoke,
			HttpServletRequest req, HttpServletResponse resp) throws Exception {

		/** remove profile url **/
		req.getSession().removeAttribute("profileUrl");

		return null;

	}

}
