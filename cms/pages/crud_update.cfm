<cfinclude template="../_templates/header.cfm">

      <!-- =============================================== -->

<cfinclude template="../_templates/nav.cfm">

      <!-- =============================================== -->

<cfif #session.page_type# eq "Blog">
  	<!-- DATE PICKER -->
  	<!-----------------> 	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">  
    <cfset omit_global_jquery = true><!--- this is in _templates/footer.cfm --->
	<script src="//code.jquery.com/jquery-1.10.2.js"></script>
	<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    
	<script>
	$(function() {
	$( "#datepicker" ).datepicker();
	});
	</script>
</cfif>

<cfoutput>

<cfinclude template="controller.cfm">
  
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
            Update #session.page_type#
            <small></small>
          </h1>
        </section>
		
        <cfif isDefined('show_message')>
        	#show_message#
        </cfif>
     
        <!-- Main content -->
        <section class="content"  style="min-height: 1200px;">

			<cfloop query="values_Page">
            <form name="manage" action="crud_update.cfm" method="post" role="form" enctype="multipart/form-data" onsubmit="showHide();">                    
                
                <div class="col-md-8">

<cfif #session.page_type# eq "Page">
<!--- PAGE top row --->

                            
						<div class="col-md-4">
                        	Navigation:<br />
                            <!--- only specific selections avaialable to customer --->
                            <cfinvoke 
                                component="#request.cfc#.pages"
                                p_parent_id = "#values_Page.p_parent_id#"
                                method="html_list_main_navigation">
                            </cfinvoke>
                      	</div>

                        
                    
                    <cfif #request.pages_allow_customer_change_layout# eq "On">
                    
						<div class="col-md-4">
							Page Layout:<br />
							<cfinvoke 
								component="#request.cfc#.page_layouts"
                                page_layout_id = "#values_Page.p_layout_fk#"
								method="html_list_layouts">
							</cfinvoke>
						</div>	
                    
                    <cfelse>
                    
                    	<input name="p_layout_fk" type="hidden" value="#values_Page.p_layout_fk#" />
                    
                    </cfif>	                            

<cfelseif #session.page_type# eq "News">
<!--- LATEST NEWS top row --->


                    <input name="p_parent_id" type="hidden" value="#values_Page.p_parent_id#" />



 					<cfif #request.pages_allow_customer_change_layout# eq "On">
                    
						<div class="col-md-4">
							Page Layout:<br />
							<cfinvoke 
								component="#request.cfc#.page_layouts"
                                page_layout_id = "#values_Page.p_layout_fk#"
								method="html_list_layouts">
							</cfinvoke>
						</div>	
                    
                    <cfelse>
                    
                    	<input name="p_layout_fk" type="hidden" value="#values_Page.p_layout_fk#" />
                    
                    </cfif>	   
                    
<cfelseif #session.page_type# eq "Blog">                  
<!--- BLOG top row --->

                   <div class="col-md-4">
                        Post On:<br />
                        <div class="input-group">
  							<span class="input-group-addon" id="sizing-addon1"><span class="glyphicon glyphicon-calendar" aria-hidden="true"></span></span>
                            <input name="p_blog_post_on" type="text" class="form-control" id="datepicker" value="#DateFormat(values_Page.p_blog_post_on, "mm/dd/yyyy")#"></input>
						</div>	   
                    </div>
                        
                    
                    <cfif #request.blog_allow_customer_change_layout# eq "On">
                    
						<div class="col-md-4">
							Blog Layout:<br />
							<cfinvoke 
								component="#request.cfc#.page_layouts"
                                page_layout_id = "#values_Page.p_layout_fk#"
								method="html_list_layouts">
							</cfinvoke>
						</div>	
                    
                    <cfelse>
                    
                    	<input name="p_layout_fk" type="hidden" value="#values_Page.p_layout_fk#" />
                    
                    </cfif>	                            
  
   						<div class="col-md-4">
							Allow Comments:<br />
							<select name="p_blog_allow_comments" class="form-control">
                            	<option value="Yes" <cfif #values_Page.p_blog_allow_comments# eq "Yes">selected</cfif>>Yes</option>
                                <option value="No" <cfif #values_page.p_blog_allow_comments# eq "No">selected</cfif>>No</option>
                            </select>
						</div>	

</cfif>
            
                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>


 
                    <div class="col-md-6">
                        Title:<br />
                        <input name="p_title" type="text" class="form-control" value="#values_Page.p_title#" />
                    </div>
            
                    <div class="col-md-6">
                        Alias: (if blank, Title will be used)<br />
						<input name="p_alias" type="text" class="form-control" value="#values_Page.p_alias#" />
                    </div>
  
                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>                  
                        
                    <div class="col-md-6">
                        Page Image / Banner Image:<br />
                        <input name="p_image" type="file" />
                        <input name="org_x_p_image" type="hidden" value="#values_Page.p_image#" />
                        <cfif #values_Page.p_image# neq "">
                        	<img src="#request.siteURL#assets/images/uploads/#values_Page.p_image#" width="150px" hspace="10px" vspace="15px" class="img-responsive" />
                            <a href="crud_update.cfm?page_id=#url.page_id#&delete_image=#values_Page.p_image#" onclick="return confirm('Are you sure you want to delete this image?');">Delete Image</a>
                        </cfif>
                    </div>
                    
                    <div class="col-md-6">
                    	<button type="button" class="btn btn-block btn-primary btn-xs" data-toggle="modal" data-target="##myModal">
                          Images
                        </button>
                    </div>
                    
                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>
                                                    
                    <div class="col-md-12">
                        Page Content:<br />
                        <!--<textarea id="txtarea" class="add_tinymce" data-required="true"></textarea>-->
                        <textarea id="txtarea" name="p_content" rows="5" data-required="true" class="mceEditor">#values_Page.p_content#</textarea>
                    </div>
                    
                    <div class="col-md-12">
                        &nbsp;<!-- spacer -->
                    </div>
                        
                    <div class="col-md-2">
                        <input name="update" type="submit" class="btn btn-success" value="Update">  
                        <input name="page_id" type="hidden" value="#values_Page.page_id#">
                        <input name="p_page_type" type="hidden" value="#session.page_type#" />           
                    </div>
                    
                    <div class="col-md-10">
                        <div id="hidden_div" style="display:none" class="pull-left">
                            <img src="#Request.siteURL#assets/images/ajax-loader.gif" /> &nbsp;&nbsp; Processing Request
                        </div>
                	</div>
                
                </div>
                
                <div class="col-md-4">
                    
                    <div role="tabpanel">
                    
                      <!-- Nav tabs -->
                      <ul class="nav nav-tabs" role="tablist">
                      	<cfif #session.page_type# eq "Blog">
                        	<li role="presentation" class="active"><a href="##categories" aria-controls="links" role="tab" data-toggle="tab">Categories</a></li>
                        <cfelseif #session.page_type# eq "Page" or #session.page_type# eq "News">
                        	<li role="presentation" class="active"><a href="##links" aria-controls="links" role="tab" data-toggle="tab">Include Links</a></li>
                        </cfif>
                        <li role="presentation"><a href="##seo" aria-controls="settings" role="tab" data-toggle="tab">SEO</a></li>
                        <cfif #session.page_type# eq "Page" or #session.page_type# eq "News">
                        	<li role="presentation" ><a href="##templates" aria-controls="profile" role="tab" data-toggle="tab">Templates</a></li>
                        </cfif>
                        <!---<li role="presentation"><a href="##social" aria-controls="settings" role="tab" data-toggle="tab">Social</a></li>--->
                      </ul>
                    
                      <!-- Tab panes -->
                      <div class="tab-content">
						
                        <cfif #session.page_type# eq "Page" or #session.page_type# eq "News">
                        <div role="tabpanel" class="tab-pane active" id="links">
                            
	                        <cfinvoke 
	            				component="#request.cfc#.pages"
	            				page_id = "#values_Page.page_id#"
	            				method="html_checkbox_pages">
	        				</cfinvoke>
                            
                        </div>
						</cfif>
                        
                        <cfif #session.page_type# eq "Blog">
                        <div role="tabpanel" class="tab-pane active" id="categories">
                            
                            <cfinvoke 
                                component="#request.cfc#.blog_categories"
                                page_id = "#values_Page.page_id#"
                                method="html_checkbox_blog_categories">
                            </cfinvoke>
                            
                        </div>
                        </cfif>
                        
                                                
                        <div role="tabpanel" class="tab-pane" id="seo">
                            Title:<br />
                            <input name="p_meta_title" type="text" class="form-control" value="#values_Page.p_meta_title#" />
                            <br />
                            Tags:<br />
                            <input name="p_meta_tags" type="text" class="form-control" value="#values_Page.p_meta_tags#" />
                            <br />
                            Description:<br />
                            <textarea name="p_meta_description" rows="6" class="form-control">#values_Page.p_meta_description#</textarea>
                        </div>
                                             
                        <div role="tabpanel" class="tab-pane" id="templates">
							<br />
                            Before Content:<br />
                            <cfinvoke 
                            	component="#request.cfc#.page_templates"
                            	before_or_after_content = "p_template_before"
                            	page_template_id = "#values_Page.p_template_before#"
                            	method="html_list_templates">
                        	</cfinvoke>
                        
                            <br />
                            After Content:<br />
                             <cfinvoke 
                            	component="#request.cfc#.page_templates"
                            	before_or_after_content = "p_template_after"
                            	page_template_id = "#values_Page.p_template_after#"
                            	method="html_list_templates">
                        	</cfinvoke> 
                                
                        </div>

                        
                        <!---
                        <div role="tabpanel" class="tab-pane" id="social">
                            
                        </div>
						--->
                        
                      </div>
                    
                    </div>
                    
                </div>                         
                    
                </form><!-- /form -->                    
				</cfloop>


        </section><!-- /.content -->

      </div><!-- /.content-wrapper -->

<!---
      <footer class="main-footer">
        <div class="pull-right hidden-md">
          <b>Thorium CF</b> Version 2.01
        </div>
        <strong>Footer Info can go here</strong>
      </footer>
 --->

 
      <!-- Add the sidebar's background. This div must be placed
           immediately after the control sidebar -->
      <div class="control-sidebar-bg"></div>
    </div><!-- ./wrapper -->


<!-- Modal Batch Upload -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close" onClick="window.location.reload()"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Image Repository</h4>
      </div>
      <div class="modal-body">
		<div class="col-md-12">
        	&nbsp;
        </div>
		<!--- get all Image File Repo Records --->
        <cfinvoke 
        	component="#request.cfc#.images_files_repo"
            method="read"
            returnvariable="records_Images_Files_Repo">
        </cfinvoke> 
        <cfloop query="records_Images_Files_Repo">
        	<div class="col-md-3">
            	<img src="#Request.siteURL#assets/images/uploads/#records_Images_Files_Repo.ifr_image#" width="90px" />
            <br />
            <input class="form-control" type="text" value="#Request.siteURL#assets/images/uploads/#records_Images_Files_Repo.ifr_image#">
            </div>
        </cfloop>
		<div class="col-md-12">
        	&nbsp;
        </div>        
      </div>
      <div class="modal-footer">
        <!---<button type="button" class="btn btn-default" data-dismiss="modal" onClick="window.location.reload()">Close</button>--->
      </div>
    </div>
  </div>
</div>

    
</cfoutput>


<script src="//tinymce.cachefly.net/4.2/tinymce.min.js"></script>
<script>tinyMCE.init({
	
	 plugins: [
            "code","link","image","paste", "autoresize"
        ],
        toolbar: "code | link | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | image ",
		image_caption: true,
		image_advtab: true,
		image_description: true,
		paste_word_valid_elements: "b,strong,i,em,h1,h2",
		mode : "specific_textareas",
		editor_selector : "mceEditor",
		autoresize_min_height: 500
});</script>
      
<cfinclude template="../_templates/footer.cfm">