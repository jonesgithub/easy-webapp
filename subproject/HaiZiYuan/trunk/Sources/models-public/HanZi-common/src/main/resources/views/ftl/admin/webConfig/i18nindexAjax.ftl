<#include "/include/dev.ftl">
<#import "/admin/imports/macro.ftl" as m>
<#import "/spring.ftl" as s />

<form id="pagerForm" action="${appServer!""}/admin/webConfig/indexAjax.htm?vmPre=i18n&cfgGroup=i18n" method="post">
		<#include "/admin/include/dwzFormBaseQuery.ftl">
    <!--【可选】其它查询条件，业务有关，有什么查询条件就加什么参数-->
	
    <input type="hidden" name="cfgName_cn" value="${(query.cfgName_cn!"")?html}"/>
    <input type="hidden" name="cfgTitle_cn" value="${query.cfgTitle_cn!""}"/>
            
</form> 


<div class="pageHeader">
    <form onsubmit="return navTabSearch(this,'${dwz.dwzId!""}');" 
    		action="${appServer!""}/admin/webConfig/indexAjax.htm?vmPre=i18n&cfgGroup=i18n" method="post">
		<#include "/admin/include/dwzFormBaseQuery.ftl">
    
    <div class="searchBar">
        <ul class="searchContent">
            <li>
                <label>i18n文件名：</label>
                    <input type="text" name="cfgName_cn" value="${query.cfgName_cn!""}" size="25"/>
            </li>
            <li>
                <label>i18n名称：</label>
                    <input type="text" name="cfgTitle_cn" value="${query.cfgTitle_cn!""}" size="25"/>
            </li>
        </ul>
        <div class="subBar">
            <ul>
                <li><div class="buttonActive"><div class="buttonContent"><button type="submit"><@s.message "queryType.query" /></button></div></div></li>
            </ul>
        </div>
    </div>
    </form>
</div>



<div class="pageContent">
    <div class="panelBar">
        <ul class="toolBar">
            <li><a class="add" href="${appServer!""}/admin/webConfig/addAjax.htm?cfgGroup=${(cfgGroup!"")?url}&navTabId=${dwz.dwzId!""}&dwzId=${dwz.dwzId!""}_add&vmPre=i18n" target="navTab" title="<@s.message "function.add" /><@s.message "i18nMessage" />" rel="${dwz.dwzId!""}_add"><span><@s.message "function.add" /></span></a></li>
            <li><a class="edit" href="${appServer!""}/admin/webConfig/editAjax/{id}.htm?cfgGroup=${(cfgGroup!"")?url}&navTabId=${dwz.dwzId!""}&dwzId=${dwz.dwzId!""}_edit&vmPre=i18n" target="navTab" title="<@s.message "function.edit" /><@s.message "i18nMessage" />" rel="${dwz.dwzId!""}_edit" ><span><@s.message "function.edit" /></span></a></li>
            <li class="line">line</li>
<!--
            <li><a href="${appServer!""}/admin/webConfig/delJson.json?navTabId=${dwz.dwzId!""}&callbackType=forward" target="selectedTodo" class="delete" title="确实要<@s.message "function.delBatch" />这些<@s.message "i18nMessage" />吗?"><span><@s.message "function.delBatch" /></span></a></li>
-->
            <li><a href="${appServer!""}/admin/webConfig/delJson/{id}.json?navTabId=${dwz.dwzId!""}&callbackType=forward" target="ajaxTodo" class="delete" title="你确定要<@s.message "function.del" />选择这条<@s.message "i18nMessage" />吗?"><span><@s.message "function.del" /></span></a></li>
        </ul>
    </div>
    <table class="table" width="100%" layoutH="138" nowrapTD="false">
        <thead>
        	<tr >
               <th width="30"><input type="checkbox" group="ids" class="checkboxCtrl"></th>
               
               <th width="80" orderField="meta32" <#if (query.orderField!"")=="meta32">class="${query.orderDirection!""}"</#if>  >功能模块 </th>
               <th width="200" orderField="cfgTitle" <#if (query.orderField!"")=="cfgTitle">class="${query.orderDirection!""}"</#if>   >i18n名称</th>
               <th  orderField="cfgName" <#if (query.orderField!"")=="cfgName">class="${query.orderDirection!""}"</#if>   >i18n文件名</th>
               <th width="80" orderField="cacheType" <#if (query.orderField!"")=="cacheType">class="${query.orderDirection!""}"</#if>   ><@s.message "WebConfig.cacheType" /> </th>
               <th width="80" orderField="rank" <#if (query.orderField!"")=="rank">class="${query.orderDirection!""}"</#if>   ><@s.message "WebConfig.rank" /> </th>
               
               <th width="60">操作</th>
            </tr>
        </thead>
        <tbody>
	       <#list page.rows as rs>
	       <tr target="id" rel="${rs.id!""}"> <!-- target="id" rel="${rs.id!""}" 这两个是用在AjaxURL中的占位({target})数据(rel)来源 -->
                <td><input name="ids" value="${rs.id!""}" type="checkbox"></td>
	            <!--
                <td> ${rs.id!""} </td>
                -->
                <td>
                    ${(rs.meta32!"")?html}
                </td>
                <td>
                    ${(rs.cfgTitle!"")?html}
                </td>
                <td>
                    ${(rs.cfgName!"")?html}
                </td>
                <td>
                	${EnumWebCfgCacheTypeMap["${rs.cacheType}"]}
                </td>
                <td>
                    ${(rs.rank!"")?html}
                </td>
        
	            <td >
	                <a href="${appServer!""}/admin/webConfig/editAjax/${rs.id?url}.htm?cfgGroup=${cfgGroup!""?url}&navTabId=${dwz.dwzId!""}&dwzId=${dwz.dwzId!""}_edit_${rs.id!""}&vmPre=i18n" target="navTab" title="<@s.message "function.edit" /><@s.message "i18nMessage" />[${rs.id!""}]" class="btnEdit"  rel="${dwz.dwzId!""}_edit_${rs.id!""}" ><@s.message "function.edit" /></a>
	            	<a href="${appServer!""}/admin/webConfig/delJson/${rs.id?url}.json?navTabId=${dwz.dwzId!""}&callbackType=forward" target="ajaxTodo" title="你确定要<@s.message "function.del" />这个<@s.message "i18nMessage" />[${rs.id!""}]吗?" class="btnDel" ><@s.message "function.del" /></a>
               <!--如果有1对多,可加上查看多方列表按钮
                -->
                </td>
	        </tr>
	       	</#list>
        </tbody>
    </table>
    <@m.dwzPageBar page "navTab"/>  
</div>

