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
package com.salesmanager.core.security;

import javax.servlet.http.HttpServletRequest;

import com.salesmanager.core.constants.SecurityConstants;

public class CustomAuthFilter extends AuthFilter {

	@Override
	String getUser(HttpServletRequest request) {
		// TODO Auto-generated method stub

		// check in the httpsession first
		String user = (String) request.getSession().getAttribute(
				SecurityConstants.SM_ADMIN_USER);

		return user;

	}

	public String getLogonPage(HttpServletRequest request) {
		return request.getContextPath() + "/profile/logon.jsp";
	}

}
