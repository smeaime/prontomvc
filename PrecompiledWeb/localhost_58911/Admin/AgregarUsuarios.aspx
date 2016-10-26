<%@ page language="VB" masterpagefile="~/MasterPage.master" autoeventwireup="false" inherits="Admin_Usuarios, App_Web_ea4s2r0n" title="Pronto Web" theme="Azul" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div align="center">
        <br />
        <table style="width: 600px">
            <tr>
                <td align="center" valign="top">
                    <asp:CreateUserWizard ID="CreateUserWizard" runat="server" ContinueDestinationPageUrl="~/ProntoWeb/Principal.aspx"
                        CssClass="t1" CellPadding="1" CellSpacing="1" LoginCreatedUser="False">
                        <ContinueButtonStyle CssClass="but" />
                        <CreateUserButtonStyle CssClass="but" />
                        <TitleTextStyle CssClass="header"  />
                        <CancelButtonStyle CssClass="but" />
                        <WizardSteps>
                            <asp:CreateUserWizardStep runat="server" Title="Datos">
                            </asp:CreateUserWizardStep>
                            <asp:CompleteWizardStep runat="server">
                            </asp:CompleteWizardStep>
                        </WizardSteps>
                        <StepStyle Font-Bold="True"  />
                        <TextBoxStyle CssClass="imp" />
                    </asp:CreateUserWizard>
                </td>
                <td align="center" valign="top">
                    <asp:Panel ID="PanelRoles" runat="server" Height="50px" Width="200px">
                        <table cellpadding="2" cellspacing="2" class="t1" style="width: 200px">
                            <tr>
                                <td class="header">
                                    Roles
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:RadioButtonList ID="RBListRoles" runat="server" Font-Bold="True" >
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <asp:Label ID="LblInfo" runat="server" Font-Bold="True" ForeColor="Red" Text="Seleccionar un rol"
                            Visible="False"></asp:Label></asp:Panel>
                </td>
            </tr>
        </table>
        &nbsp; &nbsp;&nbsp;
    </div>
</asp:Content>
