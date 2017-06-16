/* Inserts de la tabla Pais */
Insert into Pais values('Costa Rica');
Insert into Pais values('Guatemala');

/* Inserts de la tabla Rol */
Insert into Rol values('Administrador', 'Adminisrador de la aplicación');
Insert into Rol values('Fanático', 'Fanático de los festivales');

/* Inserts de la tabla Usuario */
Insert into Usuario values ('Juan', 'Navarro', 'Camacho', 'jnavcamacho@gmail.com', getdate(),'Teby','AmoAOMI',1 ,1 ,1);
Insert into Usuario values ('Juan', 'Navarro', 'Camacho', 'test@gmail.com', getdate(),'test','test', 1, 1, 1);

/* Inserts de la tabla Géneros */
Insert into GeneroMusical values('Metal');
Insert into GeneroMusical values('Rap');

/* Inserts de la tabla Banda */
Insert into Banda values('Metallica',5,1);
Insert into Banda values('Kiss',4,1);
Insert into Banda values('Eminem',4,2);
Insert into Banda values('50Cent',4,2);


/* Inserts de la tabla Album */
Insert into Album(Nombre, IdBanda,FechaCreacion) values('Metallica', 1, getdate());

Select * from Banda
join GeneroMusical on Banda.IdGenero = GeneroMusical.IdGenero
where GeneroMusical.Nombre = 'Rap'


/* Inserts de la tabla Categoria */
Insert into Categoria values ('Amantes del Rock', 'Para todos los amantes del rock', 1);
Insert into Categoria values ('Amantes del Rap', 'Para todos los amantes del rap', 1);

/* Inserts de la tabla Cartelera */
Insert into Cartelera values('Rock Imperial', 1, 'Palmares', '2017-07-04 01:37:30.823', 1)

/* Inserts de la tabla CategoriaXCartelera */
Insert into CategoriaXCartelera values(1,1)
Insert into CategoriaXCartelera values(2,1)

/* Inserts de la tabla BandaXCategoriaXCartelera */
Insert into BandaXCategoriaXCartelera values (1,1,0);
Insert into BandaXCategoriaXCartelera values (1,2,0);
Insert into BandaXCategoriaXCartelera values (2,3,0);
Insert into BandaXCategoriaXCartelera values (2,4,0);



delete from BandaXCategoriaXCartelera
select * from BandaXCategoriaXCartelera



delete from Catalogo where Nombre = 'Administrador'

select * from Cartelera
select * from CategoriaXCartelera
select * from Banda