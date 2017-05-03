create proc spInsertUser
@Username Nvarchar(50),
@DateOfBirth Nvarchar(100),
@EmailAddress Nvarchar(100),
@Password Nvarchar(100),
@ConfirmPassword Nvarchar(100)
as
Insert into Registration(Username,DateOfBirth,EmailAddress,Password,ConfirmPassword) values(@Username,@DateOfBirth,@EmailAddress,@Password,@ConfirmPassword)