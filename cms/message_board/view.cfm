<cfinclude template="../_templates/header.cfm">

      <!-- =============================================== -->

<cfinclude template="../_templates/nav.cfm">

      <!-- =============================================== -->

<cfoutput>
<!-- Data Tables -->
<link rel="stylesheet" href="#request.siteURL#assets/css_admin/plugins/datatables/dataTables.bootstrap.css">

<cfinclude template="controller.cfm">
    
      <!-- Content Wrapper. Contains page content -->
      <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
          <h1>
           Message Board
            <small></small>
          </h1>
        </section>
		
        <cfif isDefined('session.show_message')>
        	#session.show_message#
            <cfset session.show_message = "">
        </cfif>
           
        <!-- Main content -->
        <section class="content">

                    
			<table class="table table-bordered table-hover">
              
				<thead>
                    <tr>
                        <cfif $request.message_boards# eq "On">
                        <th>Image</th>
                        </cfif>
                        <th width="50px">Date</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Message</th>
                        <th>IP Address</th>
                        <th width="75px">Approved</th>
                        <th></th>
                    </tr>
				</thead>

                <!--- Records --->
				<cfloop query="records_message_board">
                <cfif #records_message_board.mb_approved# eq "1">
                	<cfset checked = "checked">
                <cfelse>
                	<cfset checked = "">
                </cfif> 
 
                <form name="edit_main_page" action="" method="post">        		
                <tr>
                	<cfif $request.message_boards# eq "On">
                    	<td>
						<cfif #records_message_board.mb_image# neq "">
                    		<img src="#Request.siteURL#assets/images/uploads/#records_message_board.mb_image#" class="img-responsive" />
                    	</cfif>
                        </td>
                    </cfif>
                    <td>#records_message_board.mb_created_on#</td>
                    <td>#records_message_board.mb_name_last#</td>
                    <td>#records_message_board.mb_name_first#</td>
                    <td>#records_message_board.mb_message#</td>
                    <td>#records_message_board.mb_ip_address#</td>
                    <td><input #checked# name="mb_approved" value="1" type="checkbox" onchange="this.form.submit()"></td>
                    <td><button name="delete" type="submit" class="btn btn-block btn-danger btn-xs" onclick="return confirm('Delete this record?')">Delete</button></td>
                </tr>
                <input name="message_board_id" type="hidden" value="#records_message_board.message_board_id#" />

                </form>
                
                </cfloop>	
                    
                             
			</table>             


        </section><!-- /.content -->
      </div><!-- /.content-wrapper -->


<!---
      <footer class="main-footer">
        <div class="pull-right hidden-xs">
          <b>Thorium CF</b> Version 2.01
        </div>
        <strong>Footer Info can go here</strong>
      </footer>
--->
 
      <!-- Add the sidebar's background. This div must be placed
           immediately after the control sidebar -->
      <div class="control-sidebar-bg"></div>
    </div><!-- ./wrapper -->
    
</cfoutput>

<cfinclude template="../_templates/footer.cfm">