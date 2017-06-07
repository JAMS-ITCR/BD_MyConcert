/* Inserts de la tabla Pais */
Insert into Pais values('Costa Rica');
Insert into Pais values('Guatemala');

/* Inserts de la tabla Rol */
Insert into Rol values('Administrador', 'Adminisrador de la aplicación');
Insert into Rol values('Fanático', 'Fanático de los festivales');

/* Inserts de la tabla Usuario */
Insert into Usuario values ('Juan', 'Navarro', 'Camacho', 'jnavcamacho@gmail.com', getdate(),'Teby','AmoAOMI',1,1);

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

delete from Catalogo where Nombre = 'Administrador'