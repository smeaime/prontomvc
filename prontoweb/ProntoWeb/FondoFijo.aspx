<%@ Page Language="VB" MasterPageFile="~/MasterPage.master" AutoEventWireup="false"
    CodeFile="FondoFijo.aspx.vb" Inherits="ComprobanteProveedor" Title="Fondo fijo" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>



<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <%--controlador de Ajax--%>
    
   
    <%--            <div id="maindiv"> 
 <div id="navdiv"> 
 <ul> 
 <li><a href="#">nested tables</a></li> 
 <li><a href="#">are very bad</a></li> 
 <li><a href="#">and that's all</a></li> 
 <li><a href="#">I'll say</a></li> 
 </ul> 
 </div> 
<p>Here we have some content. I really do miss tables. 
They are so reliable and consistent. I wonder if it's some kind of 
evil corporate conspiracy. Ah well.</p> 

</div> --%>
    
    
    
    <%--
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    ENCABEZADO OBLIGATORIO
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    --%>


    <div style="border: thin solid #FFFFFF; width: 700px; margin-top: 5px;">

      <table style="padding: 0px; border: none #FFFFFF; width: 699px; margin-right: 0px;"
                    cellpadding="3" cellspacing="3">
        
        <tr>
            <td        
                colspan="4"
                
                style=" border: thin none #FFFFFF; font-weight: bold; color: #FFFFFF; font-size: large;" 
                align="left">
                FONDO FIJO</td>
        </tr>

        
        <%--renglon vacio--%>
        <%--        <tr>
            <td        
                style="border-style: none; height: 6px;" 
                colspan="4">
                </td>
          
        </tr>--%>
        
        
        <%--Titulo--%>
<%--        <tr>
            <td style="border-width: thin; border-style: solid; height: 41px; font-size: x-large; background-color: #4A3C8C;"  colspan="4"  visible="false">
                &nbsp;
                <asp:Label ID="Label1" runat="server" Text="FONDO FIJO" Font-Bold="True" ForeColor="#F7F7F7"></asp:Label>

            </td>
          
        </tr>--%>

<%--    ////////////////////////////////////////////////////////////////////////////////////////////
--%>



        <%--renglon vacio--%>
        <tr>
<%--            <td        
                style="border-style: none; " 
                colspan="4">
                </td>--%>
          
        </tr>


        <%--referencia--%>
        <tr>
            <td style=" width: 130px; " class= "EncabezadoCell" >
                <asp:Label ID="Label4" runat="server" Text="Referencia" ForeColor="White" 
                    Font-Size="Small"></asp:Label>
            </td>
            <td class= "EncabezadoCell" style="  width: 270px;">
                <asp:TextBox ID="txtReferencia" runat="server" Width="120px" Enabled="False"></asp:TextBox>
            </td>
            
            <td class= "EncabezadoCell" style=" width: 100px;" >
                <asp:Label ID="Label3" runat="server" Text="Número" ForeColor="White" 
                    Font-Size="Small"></asp:Label>
            </td>
            <td "width: 182px" class= "EncabezadoCell" style=" ">


                    <asp:TextBox ID="txtLetra" runat="server" Width="15px" 
                        CssClass="UpperCase"
                        MaxLength="1"></asp:TextBox>
                    <cc1:FilteredTextBoxExtender id="ext" runat="server" TargetControlID="txtLetra" 
                        ValidChars="ABCEMabcem" />
                    
<%--                    <cc1:MaskedEditExtender ID="MaskedEditExtender3" 
                        runat="server" TargetControlID="txtLetra" 
                        Mask="L" MaskType="None" AutoComplete="False">
                    </cc1:MaskedEditExtender>--%>
                
                

                <asp:TextBox ID="txtNumeroComprobanteProveedor1" runat="server" Width="40px" MaxLength="4" style="text-align:right;"></asp:TextBox>
                <cc1:MaskedEditExtender ID="txtNumeroComprobanteProveedor1_MaskedEditExtender" 
                    runat="server" TargetControlID="txtNumeroComprobanteProveedor1" 
                    Mask="9999" MaskType="Number" AutoCompleteValue="0" 
                    InputDirection="RightToLeft">
                </cc1:MaskedEditExtender>

                <asp:TextBox ID="txtNumeroComprobanteProveedor2" runat="server" Width="50px" 
                        style="text-align:right;"></asp:TextBox>
                <cc1:MaskedEditExtender ID="txtNumeroComprobanteProveedor2_MaskedEditExtender" 
                    runat="server" TargetControlID="txtNumeroComprobanteProveedor2" 
                    Mask="99999999" MaskType="Number" InputDirection="RightToLeft" 
                    AutoCompleteValue="0">
                </cc1:MaskedEditExtender>
                
                
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                    ControlToValidate="txtLetra" ErrorMessage="*" 
                    ForeColor="#FF9900" Font-Size="XX-Small"></asp:RequiredFieldValidator>

                <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" 
                    ControlToValidate="txtNumeroComprobanteProveedor1" 
                    ErrorMessage="*" ForeColor="#FF9900" Font-Size="XX-Small"></asp:RequiredFieldValidator>

                <asp:RequiredFieldValidator
                ID="RequiredFieldValidator9" runat="server" 
                    ControlToValidate="txtNumeroComprobanteProveedor2" ErrorMessage="*"
                Font-Size="XX-Small" ForeColor="#FF9900" />
    
            </td>
        </tr>
        
        

        
       
    </table>
       
<%--
    ////////////////////////////////////////////
    ////////////////////////////////////////////
--%>    
       
       
            
        <%--UpdatePanel con la Cuenta + Rendicion       http://msdn.microsoft.com/en-us/library/bb386573.aspx --%>
        
        <asp:UpdatePanel ID="UpdatePanel3" runat="server" >
            <ContentTemplate>
            
    <table  style="padding: 0px; border: none; width: 773px;  height: 62px; margin-right: 0px;" 
            cellpadding="3" cellspacing="3" >  
           
            
                <%-- --%>
                <tr>
                    <td style="width: 130px; " class= "EncabezadoCell" >
                        <asp:Label ID="Label15" runat="server" Text="Cuenta" ForeColor="White" 
                            Font-Size="Small"></asp:Label>
                    </td>

                    <td class= "EncabezadoCell" style="  width: 270px;">
                        <asp:DropDownList ID="cmbCuenta" runat="server" Width="200px" 
                            AutoPostBack="True" Height="22px" />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                            ErrorMessage="*" ControlToValidate="cmbCuenta" 
                            Font-Bold="False" ForeColor="#FF9900" InitialValue="-1"></asp:RequiredFieldValidator>
                        <ajaxToolkit:ValidatorCalloutExtender ID="RequiredFieldValidator1_ValidatorCalloutExtender"
                            runat="server" Enabled="True" TargetControlID="RequiredFieldValidator1" CssClass="CustomValidatorCalloutStyle" />
                    </td>
                    
                    
                    <td class= "EncabezadoCell" style=" width: 100px;">
                    <asp:Label ID="Label2" runat="server" Text="Rendición" ForeColor="White" 
                            Font-Size="Small" />
                    </td>

                    <td class= "EncabezadoCell" style=" ">
                    <asp:TextBox ID="txtRendicion" runat="server" Width="120px" />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
                        ErrorMessage="* " ControlToValidate="txtRendicion" 
                        Font-Bold="False" ForeColor="#FF9900" Width="16px" Height="16px"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                
                <%--Obra y Tipo--%>
                <tr>             
                    
                    <td style="width: 130px; " class= "EncabezadoCell" > 
                        <asp:Label ID="Label8" runat="server" Text="Obra" ForeColor="White" 
                            Font-Size="Small"></asp:Label>
                    </td>
                        
                    <td class= "EncabezadoCell" style="  width: 270px;">
                        <asp:DropDownList ID="cmbObra" runat="server" Width="200px" Height="22px" >
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator17" runat="server" 
                            ControlToValidate="cmbobra" ErrorMessage="*" Font-Bold="False" 
                            ForeColor="#FF9900" InitialValue="-1"></asp:RequiredFieldValidator>
                    </td>


                    <td class= "EncabezadoCell" style=" width: 100px;"> 
                        <asp:Label ID="Label10" runat="server" Text="Comprobante" ForeColor="White" 
                            Font-Size="Small"></asp:Label>
                    </td>
                    <td class= "EncabezadoCell" style="">
                        <asp:DropDownList ID="cmbTipoComprobante" runat="server" Width="160px" 
                            Height="22px"/>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" 
                            ControlToValidate="cmbTipoComprobante" ErrorMessage="*" Font-Bold="False" 
                            ForeColor="#FF9900" InitialValue="-1"></asp:RequiredFieldValidator>
                    </td>

                    

                </tr>


            </table>
            </ContentTemplate>
        </asp:UpdatePanel>

    <table  style="border-style: none; border-color: inherit; border-width: medium; padding: 0px; width: 773px;  height: 33px; margin-right: 0px;" 
            cellpadding="3" cellspacing="3"  >  


        <%--confirmado--%>
        <tr>

            <td style="width: 130px;  height: 28px;" class= "EncabezadoCell">
                <asp:CheckBox ID="chkConfirmadoDesdeWeb" runat="server" ForeColor="White" 
                    Text="Listo" TextAlign="Left" Font-Size="Small" />
            </td>

            <td class= "EncabezadoCell" style="width: 270px;  height: 28px;">
            </td>

            <td class= "EncabezadoCell" style="  height: 28px; width: 100px;">
                <asp:Label ID="Label17" runat="server" Text="Fecha" ForeColor="White" 
                    Font-Size="Small" ></asp:Label>
            </td>
            
            <td class= "EncabezadoCell" style=" height: 28px;">
                <asp:TextBox ID="txtFechaComprobanteProveedor" runat="server" Width="120px" 
                    MaxLength="1"></asp:TextBox>&nbsp;&nbsp;
                <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaComprobanteProveedor">
                </cc1:CalendarExtender>
                <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AcceptNegative="Left"
                    DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                    TargetControlID="txtFechaComprobanteProveedor">
                </cc1:MaskedEditExtender>
            
                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidator5" runat="server" 
                        ControlToValidate="txtFechaComprobanteProveedor" ErrorMessage="*"
                    Font-Size="XX-Small" ForeColor="#FF9900" />

            
            </td>

        </tr>
        
        <%--Validacion del anterior renglon --%>
<%--        <tr>             
            <td style="width: 234px">
            </td>
            <td style="width: 311px">

            </td>
            <td style="width: 66px; height: 20px;"></td>
            <td style="height: 20px; width: 320px"></td>


        </tr>
--%>
 
 </table>
        <%--UpdatePanel de Proveedor--%>
             

             <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                <ContentTemplate>


     <table  style="border-style: none; border-color: inherit; border-width: medium; padding: 0px; width: 773px;  height: 112px; margin-right: 0px;" 
            cellpadding="3" cellspacing="3"  >  

            
            
                <%-- --%>
                <tr>
                    <td style="width: 130px; " class= "EncabezadoCell" >
                      <asp:Label ID="Label16" runat="server" Text="Proveedor" ForeColor="White" 
                            Font-Size="Small" ></asp:Label>
                  </td>
                <td class= "EncabezadoCell" style="" colspan="3">

                    <%--AUTOCOMPLETE--%>
                    
                    <%--
                    ////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////
                    TEXTBOX+AUTOCOMPLETE
                    truquitos autocomplete
                    http://lisazhou.wordpress.com/2007/12/14/ajaxnet-autocomplete-passing-selected-value-id-to-code-behind/#comment-106
                    ////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////////////////////////////


                --%>
                    
                    <asp:TextBox ID="txtDescArt" runat="server" autocomplete="off" AutoCompleteType="None"
                        Width="250px" 
                        OnTextChanged="btnTraerDatos_Click" AutoPostBack="True" 
                        style="margin-left: 0px"></asp:TextBox>


                    <%--donde se configuran los parametros que le paso al webservice?--%>
                    <%--al principio del load con AutoCompleteExtender1.ContextKey = SC le paso al webservice la cadena de conexion--%>
                                       
                    <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionSetCount="12"
                        EnableCaching="true" MinimumPrefixLength="1" ServiceMethod="GetCompletionList"
                        ServicePath="WebServiceProveedores.asmx" TargetControlID="txtDescArt" UseContextKey="true"
                        OnClientItemSelected="SetSelectedValue"
                        
                        
                        
                                                
                                          
                                                CompletionListCssClass="AutoCompleteScroll"
                                                FirstRowSelected="True" CompletionInterval="100" DelimiterCharacters="" >


 
                                            


                        <%--se dispara cuando se oculta la lista. me está dejando una marca fea--%>
                        <%--                    
                        <Animations>
                            <OnHide>
                               <ScriptAction Script="ClearHiddenIDField()" />  
                            </OnHide>
                        </Animations>
                        --%>

                    </cc1:AutoCompleteExtender>

                    <input id="SelectedReceiver" runat="server" type="hidden" /> <%--el hidden que guarda el id--%>
                    
                                    


                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidator7" runat="server" 
                        ControlToValidate="txtDescArt" ErrorMessage="*"
                    Font-Size="XX-Small" ForeColor="#FF9900" />
            
                                    <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender1"
                            runat="server" Enabled="True" TargetControlID="RequiredFieldValidator7" CssClass="CustomValidatorCalloutStyle" />

            
                    <asp:Button ID="btnTraerDatos" runat="server" Text="YA" Width="16px" 
                        Height="19px" CausesValidation="False" style="visibility: hidden;" />  <%--el que trae los datos del proveedor--%>



                    <script type="text/javascript">

                        function SetSelectedValue(source, eventArgs) {
                            //en eventArgs le pasan el get_text y el get_value
                            //en la linea siguiente pego el ID en el control <input> hidden
                            var a = eventArgs.get_value();
                            var id = document.getElementById('ctl00_ContentPlaceHolder1_SelectedReceiver');

                            //comento esta linea pues el proveedor no tiene codigo.... -podrías traer el CUIT... 
                            //-uf,tambien podría traer la condicion de IVA...
                            //var cod = document.getElementById('ctl00_ContentPlaceHolder1_txtCodigo');

                            var s = new Array();


                            s = a.split('^');

                            id.value = s[0]; //le aviso a clearhidden que no me pise el dato
                            //id.value = id.value + ' Che_ClearHiddenIDField_esto_es_nuevo'; //le aviso a clearhidden que no me pise el dato
                            //cod.value = s[1];

                            ///////////////////////////////
                            //deshabilitar el cuit y la condicion .....
                            document.getElementById('ctl00_ContentPlaceHolder1_txtCUIT').disabled = true;
                            document.getElementById('ctl00_ContentPlaceHolder1_cmbCondicionIVA').disabled = true;
                            //                            //.... , y llenarlos (debiera llamar al server?)
                            ///////////////////////////////

                            // opcional: fuerzo click al "go button (http://lisazhou.wordpress.com/2007/12/14/ajaxnet-autocomplete-passing-selected-value-id-to-code-behind/#comment-106)
                            // si el boton no está visible, getElementById devuelve null 
                            var but = document.getElementById('ctl00_ContentPlaceHolder1_btnTraerDatos');
                            but.click(); // .onclick();

                            //alert(a);
                            //alert(b.value);
                        }

                    </script>

                    
                    <%--                    
                    ////////////////////////////////////////////
                    AGREGADO: Un boton y 2 Funciones que uso para hacer alta al vuelo a traves 
                    de un autocomplete (no se si vale la pena)
                    ////////////////////////////////////////////
                    --%>                    

                    <%--boton explicito de alta al vuelo: el onclick hay que asignarselo por codigo--%>
                    <asp:Button ID="btnNuevoProveedor" runat="server" Text=" * " Width="25px" 
                        Height="22px" CausesValidation="False" 
                        style="visibility: hidden; margin-top: 0px; margin-left: 0px;" />     

                    
                    <script type="text/javascript">
                        function ConmutarNuevoProveedor() {

                            var id = document.getElementById('ctl00_ContentPlaceHolder1_SelectedReceiver');
                            id.value = '';
                            id = document.getElementById('ctl00_ContentPlaceHolder1_txtDescArt');
                            id.value = '';

                            if (document.getElementById('ctl00_ContentPlaceHolder1_txtCUIT').disabled) {
                                document.getElementById('ctl00_ContentPlaceHolder1_txtCUIT').disabled = false;
                                document.getElementById('ctl00_ContentPlaceHolder1_cmbCondicionIVA').disabled = false;
                                //.... , y vaciarlos
                                document.getElementById('ctl00_ContentPlaceHolder1_txtCUIT').value = '';
                                document.getElementById('ctl00_ContentPlaceHolder1_cmbCondicionIVA').value = '';
                            }
                            else {
                                ///////////////////////////////
                                //habilitar el cuit y la condicion .....
                                document.getElementById('ctl00_ContentPlaceHolder1_txtCUIT').disabled = true;
                                document.getElementById('ctl00_ContentPlaceHolder1_cmbCondicionIVA').disabled = true;
                                //.... , y vaciarlos
                                document.getElementById('ctl00_ContentPlaceHolder1_txtCUIT').value = '';
                                document.getElementById('ctl00_ContentPlaceHolder1_cmbCondicionIVA').value = '';
                                ///////////////////////////////
                            }

                            return false; // para que no haga el postback
                        }
                    </script>
                    
                    <script type="text/javascript">


                        function ClearHiddenIDField() {

                            //Do something to reset the ID Field
                            // sacado de http://blogs.msdn.com/phaniraj/archive/2007/06/19/how-to-use-a-key-value-pair-in-your-autocompleteextender.aspx

                            //return;

                            var id = document.getElementById('ctl00_ContentPlaceHolder1_SelectedReceiver');

                            // despues de setvalue se ejecuta clearhidden. tengo que ver si este es el caso
//                            var x = id.value;
//                            var st = new String;
//                            st = x.toString()
//                            alert(x);
//                            alert(1);
//                            alert(2 + st.indexOf('C'));
//                            alert(st.indexOf('Che_ClearHiddenIDField_esto_es_nuevo'));




                            if (id.value.indexOf('Che_ClearHiddenIDField_esto_es_nuevo') > -1) //acaba de pasar por setvalue?
                            {
                                var s = new Array();
                                s = id.value.split(' ');
                                id.value = s[0];
                            }
                            else
                            {
                                id.value = '';
//                                ///////////////////////////////
//                                //habilitar el cuit y la condicion .....
//                                document.getElementById('ctl00_ContentPlaceHolder1_txtCUIT').disabled = false;
//                                document.getElementById('ctl00_ContentPlaceHolder1_cmbCondicionIVA').disabled = false;
//                                //.... , y vaciarlos
//                                document.getElementById('ctl00_ContentPlaceHolder1_txtCUIT').value = '';
//                                document.getElementById('ctl00_ContentPlaceHolder1_cmbCondicionIVA').value = '';
//                                ///////////////////////////////
                                //                            
                            }

                            //alert('ClearHiddenIDField');
                            //alert(id.value);
                        }
                    </script>


<%--                
                    ////////////////////////////////////////////
                    ////////////////////////////////////////////
                    FIN DE TEXTBOX+AUTOCOMPLETE
                    ////////////////////////////////////////////
                    ////////////////////////////////////////////
--%>
                    
                


                </td>

            </tr>            
            
            <tr>

                <td style="width: 130px; " class= "EncabezadoCell">
                <asp:Label ID="Label7" runat="server" Text="CUIT" ForeColor="White" 
                        Font-Size="Small"></asp:Label>
                                </td>
                <td class= "EncabezadoCell" style="  width: 270px;">

                <asp:TextBox ID="txtCUIT" runat="server" Width="120px" Enabled="False"></asp:TextBox>


                <cc1:MaskedEditExtender ID="MaskedEditExtender4" runat="server" AcceptNegative="Left"
                    ErrorTooltipEnabled="True" Mask="99\-99999999\-9" MaskType="Number"
                    TargetControlID="txtCUIT">
                </cc1:MaskedEditExtender>

                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidator6" runat="server" 
                        ControlToValidate="txtCUIT" ErrorMessage="*"
                    Font-Size="XX-Small" ForeColor="#FF9900" />
                 <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender2"
                            runat="server" Enabled="True" TargetControlID="RequiredFieldValidator6" CssClass="CustomValidatorCalloutStyle" />    
                    
                </td>
                
                <td class= "EncabezadoCell" style=" width: 100px;">
            
                <asp:Label ID="Label6" runat="server" Text="Condición" ForeColor="White" 
                        Font-Size="Small"></asp:Label>
            
                            </td>
                <td class= "EncabezadoCell" style="">
                    <asp:DropDownList ID="cmbCondicionIVA" runat="server" Width="160px" 
                    Enabled="False" style="margin-left: 0px" Height="22px">
                </asp:DropDownList>

                <asp:RequiredFieldValidator
                    ID="RequiredFieldValidator10" runat="server" 
                        ControlToValidate="cmbCondicionIVA" ErrorMessage="*"
                    Font-Size="XX-Small" ForeColor="#FF9900" InitialValue="-1" />
                <ajaxToolkit:ValidatorCalloutExtender ID="ValidatorCalloutExtender3"
                            runat="server" Enabled="True" TargetControlID="RequiredFieldValidator10" CssClass="CustomValidatorCalloutStyle" />   

                </td>
            </tr>
            <tr>
                <td style="width: 130px; " class= "EncabezadoCell">
                    <asp:Label ID="Label13" runat="server" Text="CAI" ForeColor="White" 
                        Font-Size="Small"></asp:Label>
                </td>
                <td class= "EncabezadoCell" style="  width: 270px;">
                    <asp:TextBox ID="txtCAI" runat="server" Width="120px" MaxLength="13"></asp:TextBox>
                </td>
                <td class= "EncabezadoCell" style=" width: 100px;">

                
                <asp:Label ID="Label14" runat="server" Text="Vto. CAI" ForeColor="White" 
                        Font-Size="Small"></asp:Label>
                </td>
                <td class= "EncabezadoCell" style=" ">
      
                        
      
                    <asp:TextBox ID="txtFechaVtoCAI" runat="server" MaxLength="1" Width="120px"></asp:TextBox>
                    <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" 
                        TargetControlID="txtFechaVtoCAI">
                    </cc1:CalendarExtender>
                    <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" 
                        AcceptNegative="Left" DisplayMoney="Left" ErrorTooltipEnabled="True" 
                        Mask="99/99/9999" MaskType="Date" TargetControlID="txtFechaVtoCAI">
                    </cc1:MaskedEditExtender>
                
                    <asp:RangeValidator ID="RangeValidator1" runat="server" 
                        ErrorMessage="*"
                        Font-Size="XX-Small" ForeColor="#FF9900" 
                        ControlToValidate="txtFechaVtoCAI" Enabled="False" 
                        MaximumValue="ZZZZZZZZZZZZZZ" MinimumValue="1/1/2000" />
                </td>
            </tr>                    
            </table>
                    
       

                </ContentTemplate>
             </asp:UpdatePanel>
            

    <table  style="padding: 0px; border: none; width: 773px;  height: 62px; margin-right: 0px;" 
            cellpadding="3" cellspacing="3"  >  

        
        <%--Obs. y Liberó--%>
        <tr>
        

            <td style="width: 130px; " class= "EncabezadoCell" > 
                <asp:Label ID="Label12" runat="server" Text="Observ." ForeColor="White" 
                    Font-Size="Small"></asp:Label>
            </td>
            <td class= "EncabezadoCell" style=" width: 270px;">
                    <asp:TextBox ID="txtObservaciones" runat="server" TextMode="MultiLine" 
                        Width="260px" style="margin-left: 0px" Height="45px"></asp:TextBox>
            </td>

            <td class= "EncabezadoCell" style="  width: 101px;"> 
                <asp:Label ID="Label9" runat="server" Text="Liberó" ForeColor="White" 
                    Visible="False" Font-Size="Small"></asp:Label>
            </td>
            <td class= "EncabezadoCell" style="">
                <asp:TextBox ID="txtLibero" runat="server" Enabled="False" Width="120px" 
                    Visible="False"></asp:TextBox>
                <asp:Button ID="btnLiberar" runat="server" Text="Liberar" Visible="False" CssClass="but"
                    Width="57px" Height="24px" />
            </td>


        </tr>
            
            
         <%--renglon vacio--%>
<%--         <tr>   
            <td style="border-style: none; " 
                colspan="4">
                </td>
        </tr>--%>

        </table>
     
     </div>
<%--
    ////////////////////////////////////////////
    ////////////////////////////////////////////
--%>



<%--
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    ENCABEZADO OCULTABLE
    
    CollapsedImage="file:///C:\ProntoWeb\Proyectos\Pronto\Imagenes\5.bmp">
    
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
--%>    
    
    
<%--    <cc1:CollapsiblePanelExtender ID="CollapsiblePanelExtender1" runat="server" TargetControlID="Panel4"
        ExpandControlID="TitlePanel" CollapseControlID="TitlePanel"
        TextLabelID="Label2" ExpandedText="(Ocultar Detalles...)" CollapsedText="(Mostrar Detalles...)"
        ImageControlID="Image2" SuppressPostBack="true" ExpandedImage="~/Imagenes/1.jpg"
        CollapsedImage="~/Imagenes/4.jpg">
    </cc1:CollapsiblePanelExtender>
    <asp:Panel ID="TitlePanel" runat="server" Height="16px" ForeColor="White">
        <asp:Image ID="Image2" runat="server" ImageUrl="~/Imagenes/0.jpg" Width="26px" />&nbsp;&nbsp;
        Otros Campos&nbsp;&nbsp;
        <asp:Label ID="Label2" runat="server" ForeColor="White">(Mostrar Detalles...)</asp:Label>
    </asp:Panel>
    <asp:Panel ID="Panel4" runat="server" Height="115px" Width="769px">
        <table>
        </table>
    </asp:Panel>
    --%>





<%--    
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    SECTOR DE DETALLE (encerrado en un UpdatePanel grandote)
    
    known issues? workarounds y caveats...
    
    *problemas con updatepanel+popup    http://blogs.technet.com/kirtid/archive/2007/05/03/using-updatepanels-with-modalpopups.aspx
        en Explorer no parpadea, pero en Firefox sí....
                                        http://forums.techarena.in/software-development/1210477.htm 
        "...changed the Update Panel's UpdateMode to "Conditional" the parent UpdatePanel doesn't 
        post back when ever the child UpdatePanel posts back, and then nesting them is not a 
        problem at all as far as am concerned"
            
        "The idea behind the popup is to mainly display static or quick forms that don't need any postbacks directly.
        You are only able to drag the popup over parts of the page which have already been rendered "
            
        En cuanto agrego el updatePanel, se trula    
            
    *flick del modalpopup(al poner update panel)
                                        http://mattberseth.com/blog/2007/08/how_to_stop_the_modalpopup_fli.html
                                        http://forums.asp.net/p/997859/1312303.aspx#1312303
                                        Solucion: poner "display:none"
                                         
    *grilla y popup                     http://mattberseth.com/blog/2007/07/confirm_gridview_deletes_with.html
    
    *popup negro?                       http://forums.asp.net/p/991583/1288989.aspx
    *popup transparente?                http://forums.asp.net/p/1293702/2519794.aspx#2519794
        le cambié el css tag al panel y tambien cambie la configuracion de css modalpopup agregandole filter y opacity 
    
    UpdatePanel + GridView + ModalPopupExtender: 
                                        http://forums.asp.net/p/1007665/1339633.aspx
                                        http://stackoverflow.com/questions/1072132/refresh-gridview-inside-update-panel-after-modal-popup-closes
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
--%>




    
    <%--
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    GRILLA
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    --%>    
    <br />
    <asp:UpdatePanel ID="UpdatePanelGrilla" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <div style="OVERFLOW: auto;">

            <asp:GridView ID="GridView1" runat="server" 
        AutoGenerateColumns="False" BackColor="White"
        BorderColor="#507CBB" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="Id"
        GridLines="Horizontal" Width="702px" 
        >
        <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
        
        <Columns>
            <asp:BoundField DataField="Id" HeaderText="Id" Visible="False" />
            
            <asp:BoundField DataField="CuentaGastoDescripcion" HeaderText="Cuenta de Gasto">
                <ItemStyle Wrap="True" />
            </asp:BoundField>
            
            <asp:BoundField DataField="Importe" HeaderText="Importe sin IVA" 
                DataFormatString="{0:c}" ItemStyle-HorizontalAlign="Right" >
            
                <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            
            <asp:TemplateField HeaderText="Elim.">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("Eliminado") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    &nbsp;<asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Eval("Eliminado") %>'
                        Enabled="False" />
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:ButtonField ButtonType="Link" CommandName="Eliminar" Text="Eliminar">
                      <ControlStyle Font-Size="Small" Font-Underline="True" />
                            <ItemStyle Font-Size="X-Small" />
                            <HeaderStyle Width="40px" />
            </asp:ButtonField>
            
            <asp:ButtonField ButtonType="Link" CommandName="Editar" Text="Editar" CausesValidation="true" >
                                           <ControlStyle Font-Size="Small" Font-Underline="True" />
                            <ItemStyle Font-Size="X-Small" />
                            <HeaderStyle Width="40px" />

            </asp:ButtonField>
            
            
                  
            
        </Columns>
    
        <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
        <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
        <PagerStyle BackColor="#507CBB" ForeColor="#4A3C8C" HorizontalAlign="Right" />
        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
        <AlternatingRowStyle BackColor="#F7F7F7" />
    
    </asp:GridView>
            </div>
        
        </ContentTemplate>
        
        
        
        <Triggers>
            <%--boton que dispara la actualizacion de la grilla--%>
            <asp:AsyncPostBackTrigger ControlID="btnSaveItem" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
    
    

    <%--
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    PANEL DE EDICION DE RENGLON   (Ajax Extender has to be in the same UpdatePanel as its TargetControlID!!!)
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    --%>    
<br />

    <asp:UpdatePanel ID="UpdatePanelDetalle" runat="server">
        <ContentTemplate>


        
        <%--boton de agregar--%>        
        <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="True" 
                Font-Underline="False" ForeColor="White" CausesValidation="true" 
                Font-Size="Small" Height="43px">+   Agregar item</asp:LinkButton>
        
        <%--boton oculto (con css) obligatorio porque lo exige el modalpopup (que disparo por codebehind)--%>        
        <asp:Button ID="Button1" runat="server" Text="invisible" Font-Bold="False" 
                style="visibility: hidden;display:none"/> <%--style="visibility:hidden;"/>--%>
    
       
        <script type="text/javascript">
            // Disparando el modalpopup explícitamente para poder ejecutar cosas antes de que aparezca
            // (No lo estoy usando)
            // http://stackoverflow.com/questions/1277045/to-show-modalpopup-in-javascript
            function fnModalShow() {
                var modalDialog = $find("ModalPopupExtender3");
                // get reference to modal popup using the AJAX api $find() function

                if (modalDialog != null) {
                    modalDialog.show();
                }
            }
        </script>

        <%----------------------------------------------%>

        


        <asp:Panel ID="PanelDetalle" runat="server" Height="128px" Width="614px" 
            CssClass="modalPopup"
            style="display:none"
            > <%--Guarda! le puse display:none a través del codebehind para verlo en diseño!--%>
<%--            style="display:none"  por si parpadea
            CssClass="modalPopup" para confirmar la opacidad 
--%>            


            <table style="height: 131px" >

    <%--        
                <tr>
                    <td style="border-style: none; width: 136px">
                        <asp:Label ID="lblFechaNecesidad" runat="server" ForeColor="White" Text="Fecha de necesidad"></asp:Label>
                    </td>
                    <td style="width: 250px">
                        <asp:TextBox ID="txtFechaNecesidad" runat="server" Width="72px"></asp:TextBox>
                        <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" TargetControlID="txtFechaNecesidad">
                        </cc1:CalendarExtender>
                        <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" AcceptNegative="Left"
                            DisplayMoney="Left" ErrorTooltipEnabled="True" Mask="99/99/9999" MaskType="Date"
                            TargetControlID="txtFechaNecesidad">
                        </cc1:MaskedEditExtender>
                    </td>
                </tr>
    --%>            

                <tr>
                    <td style="border-style: none; width: 130px; height: 22px;">
                        <asp:Label ID="lblArticulo" runat="server" Text="Cuenta de Gasto" ForeColor="White"></asp:Label>
                    </td>
                    <td colspan="3" style="height: 22px">
                        <asp:TextBox ID="txtCodigo" runat="server" AutoPostBack="True" Width="80px" 
                            Visible="False"></asp:TextBox>
                        <asp:DropDownList ID="cmbCuentaGasto" runat="server" Width="400px" 
                            Font-Overline="False" ></asp:DropDownList>
                    </td>
                </tr>


                <tr>
                    <td style="width: 130px; height: 16px;">
                        <asp:Label ID="lblCantidad" runat="server" ForeColor="White" 
                            Text="Importe sin IVA"></asp:Label>
                    </td>
                    <td style="height: 16px; width: 174px">
                        <asp:TextBox ID="txtCantidad" runat="server" Width="70px"></asp:TextBox>
                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" TargetControlID="txtCantidad"
                            ValidChars=".1234567890">
                        </cc1:FilteredTextBoxExtender>
                    </td>
                    <td style="height: 16px">
                        <asp:Label ID="Label11" runat="server" ForeColor="White" Text="IVA"></asp:Label>
                    </td>
                    <td style="height: 16px">
                        &nbsp;
                        <asp:DropDownList ID="cmbIVA" runat="server" Width="80px">
                            <asp:ListItem Value="21"></asp:ListItem>
                            <asp:ListItem Value="27"></asp:ListItem>
                            <asp:ListItem Value="10.5"></asp:ListItem>
                            <asp:ListItem Value="0"></asp:ListItem>
                            <asp:ListItem Value="18.5"></asp:ListItem>
                            <asp:ListItem Value="9.5"></asp:ListItem>
                        </asp:DropDownList>
                        
                    </td>
                </tr>
                
                
                <tr>
                    <td style="width: 130px; height: 11px;">
                        <asp:Label ID="Label5" runat="server" ForeColor="White" Text="Destino"></asp:Label>
                    </td>
                    <td style="border-style: none; width: 185px; height: 11px;" colspan="3">
                        <asp:DropDownList ID="cmbDestino" runat="server" Width="200px"/>
                    </td>
                </tr>

                
                

    <%--
                ////////////////////////////////////////////////////////////////////////////////////////////
                BOTONES DE GRABADO DE ITEM  Y  CONTROL DE MODALPOPUP
                http://www.asp.net/learn/Ajax-Control-Toolkit/tutorial-27-vb.aspx
                ////////////////////////////////////////////////////////////////////////////////////////////
    --%>
                <tr>
                    <td style="width: 180px; height: 48px;">
                    </td>
                    <td align="right" style="height: 48px" colspan="3">
                        <asp:Button ID="btnSaveItem" runat="server" Font-Size="XX-Small" Text="Grabar item" CssClass="imp" 
                            UseSubmitBehavior="False" Width="82px" Height="27px" 
                            CausesValidation="False" />
                        <asp:Button ID="btnCancelItem" runat="server" Font-Size="XX-Small" 
                            Text="Cancelar" CssClass="imp" 
                            UseSubmitBehavior="False" style="margin-left: 28px; margin-right: 7px" 
                            Height="27px" CausesValidation="False" />
                    </td>
                </tr>
                
                

            </table>
        </asp:Panel>
    
        <%-- Ajax Extender has to be in the same UpdatePanel as its TargetControlID --%>
        <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender3" runat="server"      
            TargetControlId="Button1" 
            PopupControlID="PanelDetalle" 
            OkControlID="btnSaveItem"  
            CancelControlID="btnCancelItem" 
            DropShadow="False" BackgroundCssClass="modalBackground" /> 
                    <%--no me funciona bien el dropshadow  -Ya está, puse el BackgroundCssClass explicitamente!   --%>
        
    
    
    
    
    
      </ContentTemplate>
    </asp:UpdatePanel> 
    
    
    
    
    
<%--
    ////////////////////////////////////////////////////////////////////////////////////////////
    BOTONES DE ACEPTAR, CANCELAR Y WORD
    ////////////////////////////////////////////////////////////////////////////////////////////
--%>    
    
    
    <asp:Button ID="btnWord" runat="server" Style="z-index: 100; left: 0px; top: 0px"
        Text="Word" Visible="False" />
    
    
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

                <asp:UpdateProgress ID="UpdateProgress100" runat="server">
                    <ProgressTemplate>
                        <img src="Imagenes/25-1.gif" alt="" />
                        <asp:Label ID="Label2242" runat="server" Text="Actualizando datos..." ForeColor="White"
                            Visible="False"></asp:Label>
                    </ProgressTemplate>
                </asp:UpdateProgress>


            <asp:Button ID="btnSave" OnClick="btnSave_Click" runat="server" Text="Aceptar" CssClass="but" 
                UseSubmitBehavior="False"   Height="25px"
                Width="106px" Style="margin-left: 0px"  
                 Font-Size="Small"></asp:Button>  <%--le saqué el CssClass="but"--%>


            <asp:Button ID="btnCancel" OnClick="btnCancel_Click" runat="server"  CssClass="but"
                Text="Cancelar" 
                CausesValidation="False" UseSubmitBehavior="False" Width="76px"  Font-Bold="False" 
                Style="margin-left: 30px" Height="25px" Font-Size="Small"></asp:Button>
               
            <br />

        </ContentTemplate>
    </asp:UpdatePanel>




    <script type="text/javascript">
        //        var datos=new Array(); 

        //        function AbreVentanaModal(){ 
        //        datos[0]="Prueba 1"; 
        //        datos[1]="Prueba 2"; 
        //        datos[2]="Prueba 3"; 
        //        datos=showModalDialog('Firma.aspx', datos,'status:no;resizable:yes;toolbar:no;menubar:no;scrollbars:yes;help:no''); 
        //        DatoPadre1.value=datos[0]; 
        //        DatoPadre2.value=datos[1]; 
        //        DatoPadre3.value=datos[2]; 
        //        } 

        //        function okScript() {
        //            msg = 'ok';
        //        }

        //        function cancelScript() {
        //            msg = 'cancel';
        //        }

        function fnClickOK(sender, e) {
            __doPostBack(sender, e)
        }
    </script>


<%--////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    Update Progress y PANELES DE INFORMACION (con controles de modalpopup)
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
--%>

    <asp:UpdateProgress ID="UpdateProgress1" runat="server">
        <ProgressTemplate>
            <img src="Imagenes/25-1.gif" alt="" />
            Actualizando datos ...
<%--            <cc1:ModalPopupExtender ID="ModalPopupExtender2" runat="server" BackgroundCssClass="modalBackground"
                DropShadow="true" OkControlID="btnOk" PopupControlID="Panel1" PopupDragHandleControlID="Panel2"
                TargetControlID="btnLiberar">
            </cc1:ModalPopupExtender>
            <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="modalBackground"
                DropShadow="true" OkControlID="btnOk" PopupControlID="Panel1" PopupDragHandleControlID="Panel2"
                TargetControlID="btnLiberar">
            </cc1:ModalPopupExtender>
--%> </ProgressTemplate>
    </asp:UpdateProgress>
    
    
    <asp:Panel ID="PanelInfoNum" runat="server" Height="107px" Visible="false" Width="813px">
        <table style="" class="t1">
            <tr>
                <td align="center" style="font-weight: bold; color: white; background-color: green">
                    Información
                </td>
            </tr>
            <tr>
                <td style="height: 37px" align="center">
                    <strong><span style="color: #ffffff">
                        <br />
                        El RM se ha creado correctamente con<br />
                        el número: &nbsp;<asp:Label ID="LblNumero" runat="server"></asp:Label><br />
                        <br />
                        <asp:Button ID="ButVolver" runat="server" CssClass="imp" Text="Volver al listado"
                            PostBackUrl="~/ProntoWeb/ListadoRequerimientos.aspx" /><br />
                    </span></strong>
                </td>
            </tr>
        </table>
    </asp:Panel>
    
    <asp:Panel ID="PanelInfo" runat="server" Height="87px" Visible="false" Width="815px">
        <table style="" class="t1">
            <tr>
                <td align="center" style="font-weight: bold; color: white; background-color: red;
                    height: 14px;">
                    Información
                </td>
            </tr>
            <tr>
                <td style="height: 37px" align="center">
                    <strong><span style="color: #ffffff">
                        <br />
                        El RM no se ha creado correctamente&nbsp;<br />
                        <br />
                    </span></strong>
                </td>
            </tr>
        </table>
    </asp:Panel>
    
    <%--panel de usuario y password--%>
    <asp:Panel ID="Panel1" runat="server" Height="130px" Style="display: none" Width="200px"
        BackColor="DarkKhaki" BorderColor="Transparent">
        <asp:Panel ID="Panel2" runat="server" BackColor="#E0E0E0" Height="16px" Style="vertical-align: middle;
            text-align: center" Width="200px">
            Ingrese usuario y password</asp:Panel>
        <br />
        <div>
            <asp:DropDownList ID="DropDownList1" runat="server" Width="192px">
            </asp:DropDownList>
            &nbsp;
            <asp:TextBox ID="txtPass" runat="server" TextMode="Password" Width="184px"></asp:TextBox>
        </div>
        <br />
        <div>
            <asp:Button ID="btnOk" runat="server" Text="Ok" Width="80px" />
            <asp:Button ID="btnCancelarLibero" runat="server" Text="Cancelar" Width="72px" />
        </div>
    </asp:Panel>
    
    
    <%--y este?--%>
    <asp:TextBox ID="TextBox1" runat="server" Width="48px" Enabled="False" Visible="False"
        Height="27px"></asp:TextBox>


<%--////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////
--%> 



</asp:Content>
