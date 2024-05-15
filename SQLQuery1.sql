ALTER TABLE [User] 
ADD DEFAULT 'C:\Users\Olya\Desktop\YP\ImageProfile\DefaultImg.png' FOR [Image];

ALTER TABLE [User] 
ADD [IdImage] INT DEFAULT 1;

ALTER TABLE [User]  ADD [IdImage] INT DEFAULT 1 WITH VALUES;