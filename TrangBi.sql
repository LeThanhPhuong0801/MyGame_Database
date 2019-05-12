USE [Game_data]
GO

-------------------------------------------------------TAO/XOA NHAN VAT----------------------------------------------

CREATE PROC TAO_NV(@ID CHAR(10), @TEN NVARCHAR(50))
AS
BEGIN
	INSERT INTO Character(ID, Name, LV, BaseEXP, JobEXP, Attack, Def, MDef, MAttack, Money, MP, Hp, Speed, ASDP, Crit)
	VALUES(@ID, @TEN, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
END

TAO_NV '7', 'LL'

CREATE PROC XOA_NV(@ID CHAR(10))
AS
	BEGIN
	DELETE FROM
	Character
	WHERE ID = @ID
	END

XOA_NV '7'
-------------------------------------------------------CHO VAO TUI DO----------------------------------------------
CREATE PROC CHO_VAO_TUI(@ID_NV char(10), @ID_Trang_bi char(10))
	AS
		BEGIN
			IF @ID_Trang_bi LIKE 'wp%'
				BEGIN
					UPDATE Weapon
					SET ID_NV = @ID_NV
					WHERE IDWeapon = @ID_Trang_bi

					INSERT INTO TUI_DO(ID_NV, ID_TRANG_BI)
					VALUES(@ID_NV, @ID_Trang_bi)
				END
			IF @ID_Trang_bi LIKE 'a%'
				BEGIN
					UPDATE Amor
					SET ID_NV = @ID_NV
					WHERE IDAmor = @ID_Trang_bi
					INSERT INTO TUI_DO(ID_NV, ID_TRANG_BI)
					VALUES(@ID_NV, @ID_Trang_bi)
				END
			IF @ID_Trang_bi LIKE 'c%'
				BEGIN
					UPDATE Cloak
					SET ID_NV = @ID_NV
					WHERE IDCloak = @ID_Trang_bi
					INSERT INTO TUI_DO(ID_NV, ID_TRANG_BI)
					VALUES(@ID_NV, @ID_Trang_bi)
				END
			IF @ID_Trang_bi LIKE 'h%'
				BEGIN
					UPDATE Hat
					SET ID_NV = @ID_NV
					WHERE IDHat = @ID_Trang_bi
					INSERT INTO TUI_DO(ID_NV, ID_TRANG_BI)
					VALUES(@ID_NV, @ID_Trang_bi)
				END
			IF @ID_Trang_bi LIKE 's%'
				BEGIN
					UPDATE Shoes
					SET ID_NV = @ID_NV
					WHERE IDShoes = @ID_Trang_bi
					INSERT INTO TUI_DO(ID_NV, ID_TRANG_BI)
					VALUES(@ID_NV, @ID_Trang_bi)
				END
			IF @ID_Trang_bi LIKE 'r%'
				BEGIN
					UPDATE Ring
					SET ID_NV = @ID_NV
					WHERE IDRing = @ID_Trang_bi
					INSERT INTO TUI_DO(ID_NV, ID_TRANG_BI)
					VALUES(@ID_NV, @ID_Trang_bi)
				END
			END
GO
CHO_VAO_TUI '2', 'wp1'
GO
DROP PROC CHO_VAO_TUI
-------------------------------------------------------CHO VAO TUI DO----------------------------------------------
CREATE PROC LAY_RA(@ID_Trang_bi char(10))
	AS
		BEGIN
			IF @ID_Trang_bi LIKE 'wp%'
				BEGIN
					UPDATE Weapon
					SET ID_NV = NULL
					WHERE IDWeapon = @ID_Trang_bi

					DELETE FROM TUI_DO
					WHERE ID_TRANG_BI = @ID_Trang_bi
				END
			IF @ID_Trang_bi LIKE 'a%'
				BEGIN
					UPDATE Amor
					SET ID_NV = NULL
					WHERE IDAmor = @ID_Trang_bi

					DELETE FROM TUI_DO
					WHERE ID_TRANG_BI = @ID_Trang_bi
				END
			IF @ID_Trang_bi LIKE 'c%'
				BEGIN
					UPDATE Cloak
					SET ID_NV = NULL
					WHERE IDCloak = @ID_Trang_bi

					DELETE FROM TUI_DO
					WHERE ID_TRANG_BI = @ID_Trang_bi
				END
			IF @ID_Trang_bi LIKE 'h%'
				BEGIN
					UPDATE Hat
					SET ID_NV = NULL
					WHERE IDHat = @ID_Trang_bi

					DELETE FROM TUI_DO
					WHERE ID_TRANG_BI = @ID_Trang_bi
				END
			IF @ID_Trang_bi LIKE 's%'
				BEGIN
					UPDATE Shoes
					SET ID_NV = NULL
					WHERE IDShoes = @ID_Trang_bi

					DELETE FROM TUI_DO
					WHERE ID_TRANG_BI = @ID_Trang_bi
				END
			IF @ID_Trang_bi LIKE 'r%'
				BEGIN
					UPDATE Ring
					SET ID_NV = NULL
					WHERE IDRing = @ID_Trang_bi

					DELETE FROM TUI_DO
					WHERE ID_TRANG_BI = @ID_Trang_bi
				END
			END
GO
LAY_RA 'wp1'
DROP PROC LAY_RA

-------------------------------------------------------Deo Vu khi----------------------------------------------
CREATE PROC Deo_vu_khi(@ID_NV char(10), @ID_WP char(10))
AS
	BEGIN
		IF (SELECT Weapon FROM Character WHERE ID = @ID_NV) IS NULL AND (SELECT ID_NV FROM Weapon WHERE IDWeapon = @ID_WP) = @ID_NV
			BEGIN
			DECLARE @Atk_vu_khi int, @Atk_hien_tai int
				SET @Atk_vu_khi= (SELECT Atk FROM Weapon WHERE IDWeapon = @ID_WP)
				SET @Atk_hien_tai = (SELECT Attack FROM Character WHERE ID = @ID_NV) + @Atk_vu_khi

				UPDATE Character
					SET Weapon = @ID_WP 
					WHERE ID = @ID_NV

				UPDATE Character
					SET Attack = @Atk_hien_tai
					WHERE ID = @ID_NV

				UPDATE Weapon
					SET Dang_duoc_deo = 1
					WHERE IDWeapon = @ID_WP
				PRINT @Atk_hien_tai
			END
		ELSE
			BEGIN
				PRINT 'Khong the trang bi'
				ROLLBACK TRAN
			END
	END
GO

Deo_vu_khi '2', 'wp1'
drop proc Deo_vu_khi
GO

-------------------------------------------------------Deo Giap--------------------------------------------

CREATE PROC Deo_giap(@ID_NV char(10), @ID_AM char(10))
AS
	BEGIN
		IF (SELECT Amor FROM Character WHERE ID = @ID_NV) IS NULL AND (SELECT ID_NV FROM Amor WHERE IDAmor = @ID_AM) = @ID_NV
		BEGIN
		DECLARE @Def_giap int, @Def_hien_tai int

			SET @Def_giap= (SELECT Def FROM Amor WHERE IDAmor = @ID_AM)
			SET @Def_hien_tai = (SELECT Def FROM Character WHERE ID = @ID_NV) + @Def_giap

			UPDATE Character
				SET Amor = @ID_AM
				WHERE ID = @ID_NV

			UPDATE Character
				SET Def = @Def_hien_tai
				WHERE ID = @ID_NV

			UPDATE Amor
				SET Dang_duoc_deo = 1
				WHERE IDAmor = @ID_AM
			PRINT @Def_hien_tai
		END
		ELSE
			BEGIN
				PRINT 'Khong the trang bi'
				ROLLBACK TRAN
			END
		END
GO

Deo_giap '2', 'a1'
drop proc Deo_giap
GO

-------------------------------------------------------Deo Ao Choang--------------------------------------------

CREATE PROC Deo_ao_choang(@ID_NV char(10), @ID_CL char(10))
AS
	BEGIN
		IF (SELECT Cloak FROM Character WHERE ID = @ID_NV) IS NULL AND (SELECT ID_NV FROM Cloak WHERE IDCloak = @ID_CL) = @ID_NV
			BEGIN
		DECLARE @HP int, @HP_hien_tai int

			SET @HP= (SELECT Hp FROM Cloak WHERE IDCloak = @ID_CL)
			SET @HP_hien_tai = (SELECT Hp FROM Character WHERE ID = @ID_NV) + @HP

			UPDATE Character
				SET Cloak = @ID_CL
				WHERE ID = @ID_NV

			UPDATE Character
				SET Hp = @HP_hien_tai
				WHERE ID = @ID_NV

			UPDATE Cloak
				SET Dang_duoc_deo = 1
				WHERE IDCloak = @ID_CL
			PRINT @HP_hien_tai
		END
		ELSE
			BEGIN
				PRINT 'Khong the trang bi'
				ROLLBACK TRAN
			END
	END
GO

Deo_Ao_choang '3', 'c2'
drop proc Deo_Ao_Choang
GO

-------------------------------------------------------Deo Mu--------------------------------------------

CREATE PROC Deo_mu(@ID_NV char(10), @ID_mu char(10))
AS
	BEGIN
		IF (SELECT Hat FROM Character WHERE ID = @ID_NV) IS NULL AND (SELECT ID_NV FROM Hat WHERE IDHat = @ID_mu) = @ID_NV
			BEGIN
		DECLARE @MDef_mu int, @MDef_hien_tai int

			SET @MDef_mu= (SELECT Mdef FROM Hat WHERE IDHat = @ID_mu)
			SET @MDef_hien_tai = (SELECT MDef FROM Character WHERE ID = @ID_NV) + @MDef_mu

			UPDATE Character
				SET Hat = @ID_mu
				WHERE ID = @ID_NV

			UPDATE Character				
				SET MDef = @MDef_hien_tai
				WHERE ID = @ID_NV

			UPDATE Hat
				SET Dang_duoc_deo = 1
				WHERE IDHat = @ID_mu

			PRINT @MDef_hien_tai
			END
		ELSE
			BEGIN
				PRINT 'Khong the trang bi'
				ROLLBACK TRAN
			END
		END
GO

Deo_mu '3', 'h3'
drop proc Deo_mu
GO

-------------------------------------------------------Deo Nhan--------------------------------------------

CREATE PROC Deo_nhan(@ID_NV char(10), @ID_RI char(10))
AS
	BEGIN
		IF (SELECT Ring FROM Character WHERE ID = @ID_NV) IS NULL AND (SELECT ID_NV FROM Ring WHERE IDRing = @ID_RI) = @ID_NV
			BEGIN
		DECLARE @Crit_nhan int, @Crit_hien_tai int

			SET @Crit_nhan= (SELECT Crit FROM Ring WHERE IDRing = @ID_RI)
			SET @Crit_hien_tai = (SELECT Crit FROM Character WHERE ID = @ID_NV) + @Crit_nhan
			UPDATE Character
				SET Ring = @ID_RI
				WHERE ID = @ID_NV

			UPDATE Character
				SET Crit = @Crit_hien_tai
				WHERE ID = @ID_NV

			UPDATE Ring
				SET Dang_duoc_deo = 1
				WHERE IDRing = @ID_RI

			PRINT @Crit_hien_tai
			END
		ELSE
			BEGIN
				PRINT 'Khong the trang bi'
				ROLLBACK TRAN
			END
		END
GO

Deo_Nhan '2', 'r3'
drop proc Deo_Nhan
GO

-------------------------------------------------------Deo Giay--------------------------------------------

CREATE PROC Deo_giay(@ID_NV char(10), @ID_SH char(10))
AS
	BEGIN
		IF (SELECT Shoes FROM Character WHERE ID = @ID_NV) IS NULL AND (SELECT ID_NV FROM Shoes WHERE IDShoes = @ID_SH) = @ID_NV
			BEGIN
		DECLARE @Speed int, @Speed_hien_tai int

			SET @Speed= (SELECT Speed FROM Shoes WHERE IDShoes = @ID_SH)
			SET @Speed_hien_tai = (SELECT Speed FROM Character WHERE ID = @ID_NV) + @Speed
			UPDATE Character
				SET Shoes= @ID_SH
				WHERE ID = @ID_NV

			UPDATE Character
				SET Speed = @Speed_hien_tai
				WHERE ID = @ID_NV
			UPDATE Shoes
				SET Dang_duoc_deo = 1
				WHERE IDShoes = @ID_SH

			PRINT @Speed_hien_tai
			END
		ELSE
			BEGIN
				PRINT 'Khong the trang bi'
				ROLLBACK TRAN
			END
	END
GO

Deo_giay '3', 's3'
drop proc Deo_giay
GO

-------------------------------------------------------------Thao Vu khi----------------------------------------------------------

CREATE PROC Thao_vu_khi(@ID_NV char(10))
AS
	BEGIN
		IF (SELECT Weapon FROM Character WHERE ID = @ID_NV) IS NULL
			BEGIN
					PRINT 'Ban da thao trang bi truoc do'
					ROLLBACK TRAN
				END
		ELSE
			BEGIN
			DECLARE @Atk_vu_khi int, @Atk_hien_tai int
				SET @Atk_vu_khi= (SELECT Atk FROM Weapon WHERE IDWeapon = (SELECT Weapon FROM Character WHERE ID = @ID_NV))
				SET @Atk_hien_tai = (SELECT Attack FROM Character WHERE ID = @ID_NV) - @Atk_vu_khi

				UPDATE Weapon
					SET Dang_duoc_deo = 0
					WHERE IDWeapon = (SELECT Weapon FROM Character WHERE ID = @ID_NV)

				UPDATE Character
					SET Weapon = NULL
					WHERE ID = @ID_NV

				UPDATE Character
					SET Attack = @Atk_hien_tai
					WHERE ID = @ID_NV

				PRINT @Atk_hien_tai
			END
	END
GO

DROP PROC Thao_vu_khi
Thao_vu_khi '2'
GO

-------------------------------------------------------Thao Giap--------------------------------------------

CREATE PROC Thao_giap(@ID_NV char(10))
AS
	BEGIN
	IF (SELECT Amor FROM Character WHERE ID = @ID_NV) IS NULL
			BEGIN
					PRINT 'Ban da thao trang bi truoc do'
					ROLLBACK TRAN
				END
	ELSE
		BEGIN
		DECLARE @Def_giap int, @Def_hien_tai int

			SET @Def_giap= (SELECT Def FROM Amor WHERE IDAmor = (SELECT Amor FROM  Character WHERE ID = @ID_NV))
			SET @Def_hien_tai = (SELECT Def FROM Character WHERE ID = @ID_NV) - @Def_giap

			UPDATE Amor
				SET Dang_duoc_deo = 0
				WHERE IDAmor = (SELECT Amor FROM Character WHERE ID = @ID_NV)

			UPDATE Character
				SET Amor = NULL
				WHERE ID = @ID_NV

			UPDATE Character
				SET Def = @Def_hien_tai
				WHERE ID = @ID_NV
			PRINT @Def_hien_tai
		END
	END
GO

Thao_giap '2'
drop proc Thao_giap
GO

-------------------------------------------------------Thao Ao Choang--------------------------------------------

CREATE PROC Thao_ao_choang(@ID_NV char(10))
AS
	BEGIN
	IF (SELECT Cloak FROM Character WHERE ID = @ID_NV) IS NULL
			BEGIN
					PRINT 'Ban da thao trang bi truoc do'
					ROLLBACK TRAN
				END
	ELSE
		BEGIN
		DECLARE @HP int, @HP_hien_tai int

			SET @HP= (SELECT Hp FROM Cloak WHERE IDCloak = (SELECT Cloak FROM  Character WHERE ID = @ID_NV))
			SET @HP_hien_tai = (SELECT Hp FROM Character WHERE ID = @ID_NV) - @HP

			UPDATE Cloak
				SET Dang_duoc_deo = 0
				WHERE IDCloak = (SELECT Cloak FROM Character WHERE ID = @ID_NV)

			UPDATE Character
				SET Cloak = NULL
				WHERE ID = @ID_NV

			UPDATE Character
				SET Hp = @HP_hien_tai
				WHERE ID = @ID_NV
			PRINT @HP_hien_tai
		END
	END
GO

Thao_Ao_choang '2'
drop proc Thao_Ao_Choang
GO

-------------------------------------------------------Thao Mu--------------------------------------------

CREATE PROC Thao_mu(@ID_NV char(10))
AS
	BEGIN
	IF (SELECT Hat FROM Character WHERE ID = @ID_NV) IS NULL
			BEGIN
					PRINT 'Ban da thao trang bi truoc do'
					ROLLBACK TRAN
				END
	ELSE
		BEGIN
		DECLARE @MDef_mu int, @MDef_hien_tai int

			SET @MDef_mu= (SELECT Mdef FROM Hat WHERE IDHat = (SELECT Hat FROM  Character WHERE ID = @ID_NV))
			SET @MDef_hien_tai = (SELECT MDef FROM Character WHERE ID = @ID_NV) - @MDef_mu

			UPDATE Hat
				SET Dang_duoc_deo = 0
				WHERE IDHat = (SELECT Hat FROM Character WHERE ID = @ID_NV)

			UPDATE Character
				SET Hat = NULL
				WHERE ID = @ID_NV

			UPDATE Character
				SET MDef = @MDef_hien_tai
				WHERE ID = @ID_NV
			PRINT @MDef_hien_tai
		END
	END
GO

Thao_mu '2'
drop proc Thao_mu
GO

-------------------------------------------------------Thao Nhan--------------------------------------------

CREATE PROC Thao_nhan(@ID_NV char(10))
AS
	BEGIN
	IF (SELECT Ring FROM Character WHERE ID = @ID_NV) IS NULL
			BEGIN
					PRINT 'Ban da thao trang bi truoc do'
					ROLLBACK TRAN
				END
	ELSE
	BEGIN
		DECLARE @Crit_nhan int, @Crit_hien_tai int

			SET @Crit_nhan= (SELECT Crit FROM Ring WHERE IDRing = (SELECT Ring FROM  Character WHERE ID = @ID_NV))
			SET @Crit_hien_tai = (SELECT Crit FROM Character WHERE ID = @ID_NV) - @Crit_nhan

			UPDATE Ring
				SET Dang_duoc_deo = 0
				WHERE IDRing = (SELECT Ring FROM Character WHERE ID = @ID_NV)

			UPDATE Character
				SET Ring = NULL
				WHERE ID = @ID_NV

			UPDATE Character
				SET Crit = @Crit_hien_tai
				WHERE ID = @ID_NV
			PRINT @Crit_hien_tai
		END
	END
GO

Thao_Nhan '2'
drop proc Thao_Nhan
GO

-------------------------------------------------------Thao Giay--------------------------------------------

CREATE PROC Thao_giay(@ID_NV char(10))
AS
	BEGIN
	IF (SELECT Shoes FROM Character WHERE ID = @ID_NV) IS NULL
			BEGIN
					PRINT 'Ban da thao trang bi truoc do'
					ROLLBACK TRAN
				END
	ELSE
	BEGIN
		DECLARE @Speed int, @Speed_hien_tai int

			SET @Speed= (SELECT Speed FROM Shoes WHERE IDShoes = (SELECT Shoes FROM  Character WHERE ID = @ID_NV))
			SET @Speed_hien_tai = (SELECT Speed FROM Character WHERE ID = @ID_NV) - @Speed

			UPDATE Shoes
				SET Dang_duoc_deo = 0
				WHERE IDShoes = (SELECT Shoes FROM Character WHERE ID = @ID_NV)

			UPDATE Character
				SET Shoes= NULL
				WHERE ID = @ID_NV

			UPDATE Character
				SET Speed = @Speed_hien_tai
				WHERE ID = @ID_NV
			PRINT @Speed_hien_tai
		END
	END
GO

Thao_giay '2'
drop proc Thao_Giay
GO


--------------------------------------------------------VIEW--------------------------------------------------
CREATE VIEW XEM_TT_NV AS
	SELECT *
	FROM Character
GO

Deo_vu_khi '3', 'wp1'
Thao_vu_khi '3'
GO
Deo_giap '2', 'a1'
Thao_giap '2'
GO
Deo_ao_choang '2', 'c1'
Thao_ao_choang '2'
GO
Deo_mu '2', 'h1'
Thao_mu '2'
GO
Deo_nhan '2', 'r1'
Thao_nhan '2'
GO
Deo_giay '2', 's1'
Thao_giay '2'
GO


--------------------------------------------------------Cuong hoa vu khi--------------------------------------------------

CREATE PROC CUONG_HOA_VU_KHI (@ID_TRANG_BI CHAR(10))
	AS 
		BEGIN
			DECLARE @tien int
			SET @tien = ((SELECT Lv_cuong_hoa FROM Weapon WHERE IDWeapon = @ID_TRANG_BI)*10)
			IF (SELECT Dang_duoc_deo FROM Weapon WHERE IDWeapon = @ID_TRANG_BI) = 1
				BEGIN
					PRINT 'Xin thao trang bi truoc'
					ROLLBACK TRAN
				END
			ELSE 
				BEGIN
					IF (SELECT Money FROM Character WHERE ID = (SELECT ID_NV FROM Weapon WHERE IDWeapon = @ID_TRANG_BI)) > @tien
						BEGIN
							UPDATE Weapon
								SET Lv_cuong_hoa = Lv_cuong_hoa + 1
								WHERE IDWeapon = @ID_TRANG_BI
							UPDATE Weapon
								SET Atk = Atk + 10
								WHERE IDWeapon = @ID_TRANG_BI
							UPDATE Character
								SET Money = Money - @tien
								WHERE ID = (SELECT ID_NV FROM Weapon WHERE IDWeapon = @ID_TRANG_BI)
						END
					ELSE
						BEGIN
							PRINT 'Khong du tien'
								ROLLBACK TRAN
						END
				END
		END

DROP PROC CUONG_HOA_VU_KHI
CUONG_HOA_VU_KHI 'wp1'

--------------------------------------------------------Cuong hoa giap--------------------------------------------------

CREATE PROC CUONG_GIAP (@ID_TRANG_BI CHAR(10))
	AS 
		BEGIN
			DECLARE @tien int, @ID_NV char(10)
				SET @ID_NV = (SELECT ID_NV FROM Amor WHERE IDAmor = @ID_TRANG_BI)
				SET @tien = ((SELECT Lv_cuong_hoa FROM Amor WHERE IDAmor = @ID_TRANG_BI)*10)
			IF (SELECT Dang_duoc_deo FROM Amor WHERE IDAmor = @ID_TRANG_BI) = 1
				BEGIN
					PRINT 'Xin thao trang bi truoc'
					ROLLBACK TRAN
				END
			ELSE 
				BEGIN
					IF (SELECT Money FROM Character WHERE ID = (SELECT ID_NV FROM Amor WHERE IDAmor = @ID_TRANG_BI)) > @tien
						BEGIN
							UPDATE Amor
								SET Lv_cuong_hoa = Lv_cuong_hoa + 1
								WHERE IDAmor = @ID_TRANG_BI
							UPDATE Amor
								SET Def = Def + 10
								WHERE IDAmor = @ID_TRANG_BI
							UPDATE Character
								SET Money = Money - @tien
								WHERE ID = @ID_NV
						END
					ELSE
						BEGIN
							PRINT 'Khong du tien'
								ROLLBACK TRAN
						END
				END
		END

DROP PROC CUONG_GIAP

--------------------------------------------------------Cuong ao choang--------------------------------------------------

CREATE PROC CUONG_AO_CHOANG (@ID_TRANG_BI CHAR(10))
	AS 
		BEGIN
			DECLARE @tien int, @ID_NV char(10)
				SET @ID_NV = (SELECT ID_NV FROM Cloak WHERE IDCloak = @ID_TRANG_BI)
				SET @tien = ((SELECT Lv_cuong_hoa FROM Cloak WHERE IDCloak = @ID_TRANG_BI)*10)
			IF (SELECT Dang_duoc_deo FROM Cloak WHERE IDCloak = @ID_TRANG_BI) = 1
				BEGIN
					PRINT 'Xin thao trang bi truoc'
					ROLLBACK TRAN
				END
			ELSE 
				BEGIN
					IF (SELECT Money FROM Character WHERE ID = @ID_NV) > @tien
						BEGIN
							UPDATE Cloak
								SET Lv_cuong_hoa = Lv_cuong_hoa + 1
								WHERE IDCloak = @ID_TRANG_BI
							UPDATE Cloak
								SET Hp = Hp + 100
								WHERE IDCloak = @ID_TRANG_BI
							UPDATE Character
								SET Money = Money - @tien
								WHERE ID = @ID_NV
						END
					ELSE
						BEGIN
							PRINT 'Khong du tien'
								ROLLBACK TRAN
						END
				END
		END

DROP PROC CUONG_AO_CHOANG

--------------------------------------------------------Cuong Mu--------------------------------------------------

CREATE PROC CUONG_MU(@ID_TRANG_BI CHAR(10))
	AS 
		BEGIN
			DECLARE @tien int, @ID_NV char(10)
				SET @ID_NV = (SELECT ID_NV FROM Hat WHERE IDHat = @ID_TRANG_BI)
				SET @tien = ((SELECT Lv_cuong_hoa FROM Hat WHERE IDHat = @ID_TRANG_BI)*10)
			IF (SELECT Dang_duoc_deo FROM Hat WHERE IDHat = @ID_TRANG_BI) = 1
				BEGIN
					PRINT 'Xin thao trang bi truoc'
					ROLLBACK TRAN
				END
			ELSE 
				BEGIN
					IF (SELECT Money FROM Character WHERE ID = @ID_NV) > @tien
						BEGIN
							UPDATE Hat
								SET Lv_cuong_hoa = Lv_cuong_hoa + 1
								WHERE IDHat = @ID_TRANG_BI
							UPDATE Hat
								SET MDef = MDef + 15
								WHERE IDHat = @ID_TRANG_BI
							UPDATE Character
								SET Money = Money - @tien
								WHERE ID = @ID_NV
						END
					ELSE
						BEGIN
							PRINT 'Khong du tien'
								ROLLBACK TRAN
						END
				END
		END

DROP PROC CUONG_MU

--------------------------------------------------------Cuong NHAN--------------------------------------------------

CREATE PROC CUONG_NHAN(@ID_TRANG_BI CHAR(10))
	AS 
		BEGIN
			DECLARE @tien int, @ID_NV char(10)
				SET @ID_NV = (SELECT ID_NV FROM Ring WHERE IDRing = @ID_TRANG_BI)
				SET @tien = ((SELECT Lv_cuong_hoa FROM Ring WHERE IDRing = @ID_TRANG_BI)*10)
			IF (SELECT Dang_duoc_deo FROM Ring WHERE IDRing = @ID_TRANG_BI) = 1
				BEGIN
					PRINT 'Xin thao trang bi truoc'
					ROLLBACK TRAN
				END
			ELSE 
				BEGIN
					IF (SELECT Money FROM Character WHERE ID = @ID_NV) > @tien
						BEGIN
							UPDATE Ring
								SET Lv_cuong_hoa = Lv_cuong_hoa + 1
								WHERE IDRing= @ID_TRANG_BI
							UPDATE Ring
								SET Crit = Crit + 15
								WHERE IDRing = @ID_TRANG_BI
							UPDATE Character
								SET Money = Money - @tien
								WHERE ID = @ID_NV
						END
					ELSE
						BEGIN
							PRINT 'Khong du tien'
								ROLLBACK TRAN
						END
				END
		END

DROP PROC CUONG_NHAN
--------------------------------------------------------Cuong GIAY--------------------------------------------------

CREATE PROC CUONG_GIAY(@ID_TRANG_BI CHAR(10))
	AS 
		BEGIN
			DECLARE @tien int, @ID_NV char(10)
				SET @ID_NV = (SELECT ID_NV FROM Shoes WHERE IDShoes = @ID_TRANG_BI)
				SET @tien = ((SELECT Lv_cuong_hoa FROM Shoes WHERE IDShoes = @ID_TRANG_BI)*10)
			IF (SELECT Dang_duoc_deo FROM Shoes WHERE IDShoes = @ID_TRANG_BI) = 1
				BEGIN
					PRINT 'Xin thao trang bi truoc'
					ROLLBACK TRAN
				END
			ELSE 
				BEGIN
					IF (SELECT Money FROM Character WHERE ID = @ID_NV) > @tien
						BEGIN
							UPDATE Shoes
								SET Lv_cuong_hoa = Lv_cuong_hoa + 1
								WHERE IDShoes = @ID_TRANG_BI
							UPDATE Shoes
								SET Speed = Speed + 20
								WHERE IDShoes = @ID_TRANG_BI
							UPDATE Character
								SET Money = Money - @tien
								WHERE ID = @ID_NV
						END
					ELSE
						BEGIN
							PRINT 'Khong du tien'
								ROLLBACK TRAN
						END
				END
		END

DROP PROC CUONG_GIAY

--------------------------------------------------------VAO GUILD--------------------------------------------------

CREATE PROC THEM_THANH_VIEN(@ID_GUILD CHAR(10), @ID_NV CHAR(10))
	AS
	BEGIN
	IF (SELECT IsGuild FROM Character WHERE ID = @ID_NV) = 1
	BEGIN
		PRINT 'Da vao guild'
		ROLLBACK TRAN
	END
	ELSE
	BEGIN
		INSERT INTO CHI_TIET_GUILD(ID_GUILD, ID_NV, NGAY)
		VALUES (@ID_GUILD, @ID_NV, GETDATE())
		UPDATE Character
		SET IsGuild = 1
		WHERE ID =@ID_NV
	END
	END

DROP PROC THEM_THANH_VIEN
THEM_THANH_VIEN 'G3', '2'

CREATE PROC XOA_THANH_VIEN(@ID_NV CHAR(10))
	AS
	BEGIN
		DELETE FROM CHI_TIET_GUILD
		WHERE ID_NV = @ID_NV
		UPDATE Character
		SET IsGuild = 0
		WHERE ID = @ID_NV
	END

drop proc XOA_THANH_VIEN

XOA_THANH_VIEN '2'
GO
------------------------------*****----------------------------

------------------------------------proc sat thuong len quai ------------------------------
create proc st_len_quai(@IDnv char(10) , @IDquai char(10) )
as 
	begin
		declare @id int, @atk1 float , @def float , @atk float , @hp float , @crit float , @henv char , @heq char 
		set @atk1 = (select Attack from Character where ID = @IDnv)
		set @def = (select Defq from quai where IDq = @IDquai)
		set @crit = RAND() * 100
		set @henv = (select He from Character where ID = @IDnv)
		set @heq = (select he from Quai where IDq = @IDquai)
		if( (@henv like 'h%' and @heq like 'p%') or (@henv like 'p%' and @heq like 'l%') or (@henv like 'l%' and @heq like'd%') or (@henv like 'd%' and @heq like't%') or (@henv like 't%' and @heq like 'h%'))
		begin
			if(@crit < (select Crit from Character where ID = @IDnv))
				begin
					set @atk = @atk1*4 - @def
				end
			else 
				begin 
					set @atk = @atk1*2 - @def
				end
		end
		else 
		begin 
			if( (@henv like 'p%' and @heq like 'h%') or (@henv like 'l%' and @heq like 'p%') or (@henv like 'd%' and @heq like'l%') or (@henv like 't%' and @heq like'd%') or (@henv like 'h%' and @heq like 't%'))
			begin
				if(@crit < (select Crit from Character where ID = @IDnv))
					begin
						set @atk = @atk1 - @def
					end
				else 
					begin 
						set @atk = @atk1/2 - @def
					end
			end
			else 
				begin 
						if(@crit < (select Crit from Character where ID = @IDnv))
					begin
						set @atk = @atk1*2 - @def
					end
				else 
					begin 
						set @atk = @atk1 - @def
					end
				end
		end
		if @atk < 0
		begin
			set @atk = 0
		end
		set @hp=(select Hpq from quai where IDq = @IDquai)
			if (@hp > 0)
				begin
					update quai
					set Hpq = @hp - @atk
					where IDq=@IDquai
					
					insert into danhquai (ID, IDq, st_gay , Hp_con_lai, ngay)
					values ( @IDnv, @IDquai, @atk ,@hp - @atk, getdate() )
				end
			else
				begin
					print 'quai da chet'
					rollback tran
				end 
	end
	go

drop proc st_len_quai

st_len_quai '2', '333' 

--------------------------------------------hp nv mat------------------------------------------
create proc st_nv_nhan(@IDnv char(10) , @IDquai char(10) )
as 
	begin
		declare @id int, @atk1 float , @def float , @atk float , @hp float , @kq float , @total float , @henv char , @heq char
		set @atk1 = (select Atkq  from quai where IDq = @IDquai)
		set @def = (select Def  from Character where ID = @IDnv)
		set @henv = (select He from Character where ID = @IDnv)
		set @heq = (select he from quai where IDq = @IDquai)
		
		if( (@henv like 'h%' and @heq like 'p%') or (@henv like 'p%' and @heq like 'l%') or (@henv like 'l%' and @heq like'd%') or (@henv like 'd%' and @heq like't%') or (@henv like 't%' and @heq like 'h%'))
			begin
				set @atk = @atk1/2 - @def
			end
		else
		begin 
			if( (@henv like 'p%' and @heq like 'h%') or (@henv like 'l%' and @heq like 'p%') or (@henv like 'd%' and @heq like'l%') or (@henv like 't%' and @heq like'd%') or (@henv like 'h%' and @heq like 't%'))	
				begin
					set @atk = @atk1*2 -@def
				end
			else 
				begin 
					set @atk = @atk1 - @def
				end 
		end
		if @atk < 0
		begin
			set @atk = 0
		end
		set @hp=(select Hp from Character where ID = @IDnv)
		if (@hp > 0)
			begin
				update Character
				set Hp = @hp - @atk
				where ID=@IDnv
				
				insert into Hp_mat_nv(ID, IDq, St_nhan ,Hp_nv_mat, ngay)
				values (@IDnv,@IDquai, @atk ,@hp - @atk , getdate())
			end
		else
			begin
				print 'nhan vat da chet'
				rollback tran
			end 
	end

GO

drop proc st_nv_nhan
st_nv_nhan '2', '555'
go

--------------------------------------------nhan vat vs nhan vat------------------------------------------
create proc st_nv_vs_nv2(@IDnv char(10) , @IDnv2 char(10) )
as 
	begin
		declare @id int, @atk1 float , @def float , @atk float , @hp float , @kq float , @total float , @henv char , @henv2 char, @crit float
		set @atk1 = (select Attack  from Character where ID = @IDnv)
		set @def = (select Def  from Character where ID = @IDnv2)
		set @henv = (select He from Character where ID = @IDnv)
		set @henv2 = (select He from Character where ID = @IDnv2)
		set @crit = RAND()*100
		if( (@henv like 'h%' and @henv2 like 'p%') or (@henv like 'p%' and @henv2 like 'l%') or (@henv like 'l%' and @henv2 like'd%') or (@henv like 'd%' and @henv2 like't%') or (@henv like 't%' and @henv2 like 'h%'))
		begin
			if(@crit < (select Crit from Character where ID = @IDnv))
				begin
					set @atk = @atk1*4 - @def
				end
			else 
				begin 
					set @atk = @atk1*2 - @def
				end
		end
		else 
		begin 
			if( (@henv like 'p%' and @henv2 like 'h%') or (@henv like 'l%' and @henv2 like 'p%') or (@henv like 'd%' and @henv2 like'l%') or (@henv like 't%' and @henv2 like'd%') or (@henv like 'h%' and @henv2 like 't%'))
			begin
				if(@crit < (select Crit from Character where ID = @IDnv))
					begin
						set @atk = @atk1 - @def
					end
				else 
					begin 
						set @atk = @atk1/2 - @def
					end
			end
			else 
				begin 
						if(@crit < (select Crit from Character where ID = @IDnv))
					begin
						set @atk = @atk1*2 - @def
					end
				else 
					begin 
						set @atk = @atk1 - @def
					end
				end
		end
		if @atk < 0
		begin
			set @atk = 0
		end
		
		set @hp=(select Hp from Character where ID = @IDnv)
		if (@hp > 0)
			begin
				update Character
				set Hp = @hp - @atk
				where ID=@IDnv
				
				insert into NV_VS_NV(IDNV1, IDNV2, ST_GAY_RA, MAU_NV2_CON_LAI, NGAY)
				values (@IDnv,@IDnv2, @atk ,@hp - @atk , getdate())
			end
		else
			begin
				print 'nhan vat da chet'
				rollback tran
			end 
	end

GO

drop proc st_nv_vs_nv2
st_nv_vs_nv2 '3', '2'
go
--------------------------****--------------------
--------------------SHOW BANG NV------------------------
select*
from Character
where id = 2
GO
-------------------QUA TRINH DEO TRANG BI----------------------
---***----DEO---TRANG---BI----***----
exec Deo_vu_khi '2' , 'wp1'
exec CHO_VAO_TUI '2' , 'c1'
exec Deo_mu '2' , 'h1'
exec Deo_giap '2' , 'a1'
exec Deo_ao_choang '2' , 'c1'
exec Deo_nhan '2' , 'r1'
exec Deo_giay '2' , 's1'
---***----THAO---TRANG---BI----***----
exec Thao_vu_khi '2'
exec Thao_mu '2' 
exec Thao_giap '2' 
exec Thao_ao_choang '2' 
exec Thao_nhan '2' 
exec Thao_giay '2'
GO
----------------------CUONG HOA TRANG BI -------------------------
exec CUONG_HOA_VU_KHI 'wp1'
exec CUONG_MU 'm1'
exec CUONG_GIAP 'a1'
exec CUONG_AO_CHOANG 'c1'
exec CUONG_NHAN 'r1'
exec CUONG_GIAY 's1'
GO

----------------------QUA TRINH VAO GUILD---------------------------
exec THEM_THANH_VIEN 'G2' , '3'
exec XOA_THANH_VIEN  '3'
select*
from CHI_TIET_GUILD
go
----------------------QUA TRINH GAY SAT THUONG LEN QUAI--------------
exec st_len_quai '2' , '222'
select*
from danhquai
go
----------------------QUA TRINH TUONG NHAN SAT THUONG-----------------
exec st_nv_nhan '2', '111'
select*
from Hp_mat_nv

----------------------QUA TRINH NHAN VAT DANH NHAU-----------------

exec st_nv_vs_nv2 '3', '2'

Select *
from NV_VS_NV
	