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

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import org.apache.commons.collections.BidiMap;
import org.apache.commons.collections.bidimap.TreeBidiMap;
import org.apache.commons.lang.StringUtils;

public class StringUtil {

	/**
	 * Build a ; delimited line with the values contained in the list
	 * 
	 * @param list
	 * @return
	 */
	public static String buildMultipleValueLine(List list) {

		if (list != null & list.size() > 0) {

			Iterator i = list.iterator();
			StringBuffer linebuffer = new StringBuffer();
			int icount = 0;
			while (i.hasNext()) {
				String value = (String) i.next();
				linebuffer.append(value);
				if (icount < list.size() - 1)
					linebuffer.append(";");
				icount++;
			}
			return linebuffer.toString();
		} else {
			return null;
		}
	}

	public static Map parseTokenLine(String line, String delimiter) {

		BidiMap returnMap = new TreeBidiMap();

		if (StringUtils.isBlank(line) || StringUtils.isBlank(delimiter)) {
			return returnMap;
		}

		StringTokenizer st = new StringTokenizer(line, delimiter);

		int count = 0;
		while (st.hasMoreTokens()) {
			String value = st.nextToken();
			returnMap.put(value, count);
			count++;
		}

		return returnMap;

	}
	
	
	public static Map deformatUrlResponse(String payload) throws Exception {
		HashMap nvp = new HashMap();
		StringTokenizer stTok = new StringTokenizer(payload, "&");
		while (stTok.hasMoreTokens()) {
			StringTokenizer stInternalTokenizer = new StringTokenizer(stTok
					.nextToken(), "=");
			if (stInternalTokenizer.countTokens() == 2) {
				String key = URLDecoder.decode(stInternalTokenizer.nextToken(),
						"UTF-8");
				String value = URLDecoder.decode(stInternalTokenizer
						.nextToken(), "UTF-8");
				nvp.put(key.toUpperCase(), value);
			}
		}
		return nvp;
	}

}
