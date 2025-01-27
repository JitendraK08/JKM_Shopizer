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
package com.salesmanager.central;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;
import com.opensymphony.xwork2.validator.ValidationException;
import com.salesmanager.central.shipping.ShippingModuleActionInterceptor;

public class CentralBaseInterceptor implements Interceptor {

	private Logger log = Logger
			.getLogger(ShippingModuleActionInterceptor.class);

	public void destroy() {
		// TODO Auto-generated method stub

	}

	public void init() {
		// TODO Auto-generated method stub

	}

	public String intercept(ActionInvocation invoke) throws Exception {
		// TODO Auto-generated method stub
		try {
			return invoke.invoke();
		} catch (Exception e) {
			if (e instanceof ValidationException) {// do nothing
				return com.opensymphony.xwork2.Action.SUCCESS;
			}
			if (e instanceof AuthorizationException) {// return to dashborad
				return "AUTHORIZATIONEXCEPTION";
			}
			log.error(e);
			return "GENERICERROR";


		}
	}

}
