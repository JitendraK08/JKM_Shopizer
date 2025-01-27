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
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.struts2.interceptor.PrincipalProxy;

import com.salesmanager.central.BaseAction;
import com.salesmanager.core.entity.reference.DynamicLabel;
import com.salesmanager.core.service.ServiceFactory;
import com.salesmanager.core.service.reference.ReferenceService;


/**
 * Common content attributes
 * @author Carl Samson
 *
 */
public abstract class ContentAction extends BaseAction {
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -2458466574834932255L;
	protected List<String> titles = new ArrayList<String>();
	protected List<String> descriptions = new ArrayList<String>();
	
	String[] visible;// selected page content
	
	
	protected List<String> sefurl = new ArrayList<String>();
	protected String pageTitle;
	
	protected DynamicLabel label = null;

	protected Collection<DynamicLabel> pages = null;
	
	
	

	public String[] getVisible() {
		return visible;
	}

	public void setVisible(String[] visible) {
		this.visible = visible;
	}

	private Logger log = Logger.getLogger(ContentAction.class);
	
	public List<String> getTitles() {
		return titles;
	}

	public void setTitles(List<String> titles) {
		this.titles = titles;
	}

	public List<String> getDescriptions() {
		return descriptions;
	}

	public void setDescriptions(List<String> descriptions) {
		this.descriptions = descriptions;
	}

	public List<String> getSefurl() {
		return sefurl;
	}

	public void setSefurl(List<String> sefurl) {
		this.sefurl = sefurl;
	}

	public String getPageTitle() {
		return pageTitle;
	}

	public void setPageTitle(String pageTitle) {
		this.pageTitle = pageTitle;
	}

	public DynamicLabel getLabel() {
		return label;
	}

	public void setLabel(DynamicLabel label) {
		this.label = label;
	}

	public Collection<DynamicLabel> getPages() {
		return pages;
	}

	public void setPages(Collection<DynamicLabel> pages) {
		this.pages = pages;
	}

	




}
