use bdlmaster

select * from aspnet_users

SELECT * FROM BASES

select * from DetalleUserBD

select * from userdatosextendidos

SELECT * FROM BASES join DetalleUserBD on bases.IdBD=DetalleUserBD.IdBD 
where lower(UserId)='705e6364-4535-4fcc-8746-a1ade8c66c98' AND Descripcion='Capen'  
go


bdlmaster.dbo.wResetearPass '30-65663161-1','30-65663161-'1
bdlmaster.dbo.wResetearPass 'Mariano','pirulo!'
bdlmaster.dbo.wResetearPass 'esucoreq','esucoreq!'

delete from Bases where IdBD=16


--Rather than writing INSERT statements by hand, use the stored procedures that are part of the SqlMembershipProvider implementation provider and are included when installing application services using the aspnet_reg.exe tool.

--In particular, use:

--aspnet_Roles_CreateRole to create a new role
--aspnet_Membership_CreateUser to create a user and supply his membership data (password, security question and answer, and so forth)
--aspnet_UsersInRoles_AddUsersToRoles to add an existing user to an existing role

[aspnet_Roles_CreateRole] '/','ExternoCuentaCorrienteCliente'  --ejecutar en la bdlmaster
[aspnet_Roles_CreateRole] '/','SuperAdmin'  --ejecutar en la bdlmaster
[aspnet_Roles_CreateRole] '/','AdminExterno'  --ejecutar en la bdlmaster
[aspnet_Roles_DeleteRole] '/','WilliamsAdmin','false'  --ejecutar en la bdlmaster
go

aspnet_UsersInRoles_AddUsersToRoles '/','Mariano','SuperAdmin',''
aspnet_UsersInRoles_AddUsersToRoles '/','supervisor','SuperAdmin',''
aspnet_UsersInRoles_AddUsersToRoles '/','supervisor','WilliamsAdmin',''



aspnet_UsersInRoles_AddUsersToRoles

 exec aspneaspnet_Membership_CreateUser '/'

 sp_helptext 'aspnet_UsersInRoles_AddUsersToRoles'




