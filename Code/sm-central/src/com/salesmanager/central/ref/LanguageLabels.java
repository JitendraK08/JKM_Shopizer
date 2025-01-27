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
package com.salesmanager.central.ref;

import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.ResourceBundle;

import com.salesmanager.core.constants.PaymentConstants;
import com.salesmanager.core.entity.reference.ProductType;

public class LanguageLabels {

	/**
	 * Actions for credit card processing
	 * 
	 * @param lang
	 * @return
	 */
	public static Map getCreditCardActions(String lang) {
		Map cardactions = new HashMap();

		if (lang.equals("en")) {
			cardactions.put(PaymentConstants.PREAUTH, "Pre-Authorize");
			cardactions.put(PaymentConstants.SALE, "Sale");
		}
		if (lang.equals("fr")) {
			cardactions.put(PaymentConstants.PREAUTH, "Pré-Authorization");
			cardactions.put(PaymentConstants.SALE, "Achat");
		}
		return cardactions;

	}

	public static Map buildYesNo(String lang) {

		Map env = new HashMap();
		if (lang.equals("en")) {
			env.put(new Integer(1).intValue(), "Yes");
			env.put(new Integer(0).intValue(), "No");
		}
		if (lang.equals("fr")) {
			env.put(new Integer(1).intValue(), "Oui");
			env.put(new Integer(0).intValue(), "Non");
		}
		return env;
	}

	public static Map buildSuccessFail(String lang) {

		Map env = new HashMap();
		if (lang.equals("en")) {
			env.put(new Integer(1).intValue(), "Success");
			env.put(new Integer(0).intValue(), "Fail");
		}
		if (lang.equals("fr")) {
			env.put(new Integer(1).intValue(), "Succès");
			env.put(new Integer(0).intValue(), "Échec");
		}
		return env;
	}

	public static Map buildTrueFalse(String lang) {

		Map env = new HashMap();
		if (lang.equals("en")) {
			env.put(new Boolean(true), "Yes");
			env.put(new Boolean(false), "No");
		}
		if (lang.equals("fr")) {
			env.put(new Boolean(true), "Oui");
			env.put(new Boolean(false), "Non");
		}
		return env;
	}

	public static Map getProductTypes(String lang, Collection types) {
		Map typesmap = new HashMap();

		Types t = new Types();
		if (lang.equals("en")) {
			t.setLang("en");
		}
		if (lang.equals("fr")) {
			t.setLang("en");
		}
		t.load(types.size());
		Iterator kit = types.iterator();
		while (kit.hasNext()) {
			ProductType pt = (ProductType) kit.next();
			pt.setTypeName(t.getType(pt.getTypeId()));
			typesmap.put(pt.getTypeId(), pt);
		}

		return typesmap;

	}

	public static Map useCVV(String lang) {
		Map cardactions = new HashMap();

		if (lang.equals("en")) {
			cardactions.put("1", "Do not use");
			cardactions.put("2", "Use");
		}
		if (lang.equals("fr")) {
			cardactions.put("1", "Ne pas utiliser");
			cardactions.put("2", "Utiliser");
		}
		return cardactions;

	}

}

class Types {

	private String localleng;
	private Map content = new HashMap();

	public void setLang(String lang) {
		localleng = lang;
	}

	public void load(int maxsize) {
		ResourceBundle bundle = null;
		bundle = ResourceBundle.getBundle("central-catalog");
		if (bundle != null) {
			for (int i = 1; i <= maxsize; i++) {
				String type = bundle.getString("label.product.types." + i);
				content.put(i, type);
			}
		}
	}

	public String getType(int i) {
		if (content.containsKey(new Integer(i))) {
			return (String) content.get(new Integer(i));
		} else {
			return "";
		}
	}
}
