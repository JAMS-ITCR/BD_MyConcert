/* Tabla que almacena los datos compartidos emtre los usuarios (Administradores y Fan�ticos) */
Create table Usuario (
	/* Identificador �nico autoincremental para cada usuario */
	IdUsuario int identity(1,1) primary key,
	/* Nombre del Usuario (Nombre de persona) */
	Nombre varchar(30) not null,
	/* Primer apellido del usuario */
	Apellido1 varchar(30) not null,
	/* Segundo apellido del usuario */
	Apellido2 varchar(30) not null,
	/* Correo Electr�nico del usuario */
	CorreoElectronico varchar(50) not null,
	/* Fecha y hora en la que el usuario se est� registrando en el sistema */
	FechaInscripcion datetime not null,
	/* Nombre de usuario para el inicio de sesi�n */
	NombreUsuario varchar(30) not null,
	/* Contrase�a del usuario para el inicio de sesi�n */
	Contrase�a varchar(8) not null,
	/* Identificador del rol que tiene el usuario (Administrador o Fan�tico) referenciado a la tabla Rol */
	IdRol int not null,
	/* Estado del usuario (activo, inactivo) */
	Estado bit not null,
	/* Indicador de una sesi�n activa en el sistema para un usuario */
	SesionActiva bit not null
)

/* Tabla que especifica los datos adicionales que se guardan para los fan�ticos */
Create table DetalleFanatico (
	/* Referencia al identificador �nico en la tabla Usuario */
	IdUsuario int not null,
	/* Fecha de Nacimiento del fan�tico */
	FechaNacimiento date not null,
	/* Referencia al identificador �nico en la tabla Pais */
	IdPais int not null,
	/* Ubicaci�n del Fan�tico, lugar donde vive */
	Ubicacion varchar(100),
	/* Universidad donde estudia en caso de aplicar */
	Universidad varchar(30),
	/* N�mero de tel�fono del Fan�tico */
	Telefono varchar(15) not null,
	/* Foto de perfil del Fan�tico */
	Foto varchar(max), 
	/* Breve descripci�n personal del fan�tico */
	DescripcionPersonal varchar(300) not null
)

/* Tabla para los g�neros musicales disponibles dentro del sistema */
Create table GeneroMusical (
	/* Identificador �nico autoincremental para cada g�nero musical */
	IdGenero int identity(1,1) primary key,
	/* Nombre del g�nero musical */
	Nombre varchar(50) not null,
)

/* Tabla que relaciona los g�neros musicales que pertenecen a un usuario */
Create table GeneroXUsuario (
	/* Identificador del g�nero musical */
	IdGenero int not null, 
	/* Identificador del usuario */
	IdUsuario  int not null
)

/* Tabla para las bandas/artistas disponibles en el cat�logo del sistema */
Create table Banda (
	/* Identificador �nico autoincremental para cada banda/artista */
	IdBanda int identity(1,1) primary key,
	/* Nombre de la banda/artista */
	Nombre varchar(100) not null,
	/* Promedio de los ratings dados por los fan�ticos en sus comentarios */
	PromedioRating int not null,
	/* Identificador del g�nero de la Banda/artista */
	IdGenero int not null
)

/* Tabla para las personas que conforman una banda (miembros) */
Create table MiembroBanda (
	/* Identificador �nico autoincremental para cada miembro de banda */
	IdMiembroBanda int identity(1,1) primary key,
	/* Nombre del miembro */
	Nombre varchar(100) not null,
	/* Identificador de la banda a la que pertenece */
	IdBanda int not null
)

/* Tabla para los �lbumes de las bandas */
Create table Album (
	/* Identificador �nico autoincremental para el �lbum */
	IdAlbum int identity(1,1) primary key,
	/* Nombre del �lbum */
	Nombre varchar(100) not null,
	/* Identificador de la banda a la que pertenece el �lbum */
	IdBanda int not null,
	/* Imagen del �lbum (car�tula) */
	Imagen image not null,
	/* Fecha de creaci�n del �lbum */
	FechaCreacion datetime not null,
)

Create table Cancion (
	/* Identificador �nico autoincremental para cada canci�n */
	IdCancion int identity(1,1) primary key,
	/* Nombre de la canci�n */
	Nombre varchar(100) not null,
	/* V�nculo del preview de la canci�n */
	Preview varchar(100) not null,
	/* Imagen de la canci�n */
	Imagen image not null,
	/* Fecha de creaci�n de la canci�n */
	FechaCreacion datetime not null,
	/* Identificador de la banda a la que se asocia la canci�n */
	IdBanda int not null,
	/* Identificador del G�nero de la canci�n */
	IdGenero int not null,
	/* Identificador del �lbum al que pertenece la canci�n */
	IdAlbum int not null,
	/* Estado de la canci�n */
	Estado bit not null
)

Create table Comentario (
	/* Identificador �nico autoincremental para cada comentario */
	IdComentario int identity(1,1) primary key,
	/* Identificador del usuario que hizo el comentario */
	IdUsuario int not null,
	/* Identificador de la banda al que se le hizo el comentario */
	IdBanda int not null,
	/* N�mero con el rating que el usuario di� a la banda/artista */
	Rating int not null,
	/* Contenido del comentario */
	Contenido varchar(500) not null,
	/* Feacha en la que se cre� el comentario */
	FechaCreacion datetime not null,
	/* Estado del comentario (activo, inactivo) */
	Estado bit not null
)

/* Tabla que almecenar� los pa�ses que soporta el sistema */
Create table Pais (
	/* Identificador �nico autoincremental para cada pa�s */
	IdPais int identity(1,1) primary key,
	/* Nombre del pa�s */
	NombrePais varchar(50) not null,
)

/* Tabla que almacenar� los roles con los que un usario puede iniciar sesi�n*/
Create table Rol (
	/* Identificador �nico autoincremental para cada rol  */
	IdRol int identity(1,1) primary key,
	/* Nombre del Rol */
	NombreRol varchar(50) not null,
	/* Breve descripci�n del rol */
	Descripcion varchar(500)
)

/* Tabla para las carteleras generadas */
Create table Cartelera (
	/* Identificador �nico autoincremental para cada cartelera */
	IdCartelera int identity(1,1) primary key,
	/* Nombre de la cartelera */
	Nombre varchar(100) not null,
	/* Referencia al identificador del pa�s donde se va a realizar el pa�s */
	IdPais int not null,
	/* Lugar donde se realizar� el posible festival */
	Lugar varchar(100) not null,
	/* Fecha y hora a la cu�l las votaciones cerrar�n */
	CierreVotacion datetime not null,
	/* Estado de la cartelera */
	Estado bit not null
)

/* Tabla para las categor�as disponibles en el sistema */
Create table Categoria (
	/* Identificador �nico autoincremental para cada categor�a */
	IdCategoria int identity(1,1) primary key,
	/* Nombre de la categor�a */
	Nombre varchar(100) not null,
	/* Descripci�n de la categor�a */
	Descripcion varchar(500) not null,
	/* Estado de la categor�a */
	Estado bit not null
)

/* Tabla para relacionar las categor�as con una cartelera */
Create table CategoriaXCartelera (
	/* Identificador �nico autoincremental para cada registro */
	IdCategoriaXCartelera int identity(1,1) primary key,
	/* Identificador de la categor�a */
	IdCategoria int not null,
	/* Identificador de la cartelera */
	IdCartelera int not null
)

/**/
Create table BandaXCategoriaXCartelera (
	/* Referencia al identificador �nico de un registro en la tabla 
	CategoriaXCartelera de una categor�a agregada a una Cartelera */
	IdCategoriaXCartelera int not null,
	/* Referencia al identificador �nico de una canci�n en la tabla Cancion */
	IdBanda int not null
)

/* Tabla para los Festivales creados en el sistema */
Create table Festival (
	/* Identificador �nico autoincremental para cada Festival */
	IdFestival int identity(1,1) primary key,
	/* Nombre del Festival */
	Nombre varchar(100) not null,
	/* Referencia al identificador del pa�s donde se realizar� el festival */
	IdPais int not null,
	/* Nombre del lugar donde se har� el festival */
	Lugar varchar(100) not null,
	/* Fecha de Inicio del Festival */
	FechaInicio datetime not null,
	/* Fecha de finalizaci�n del festival */
	FechaFinal datetime not null,
	/* Detalles acerca del transporte */
	Transporte varchar(500) not null,
	/* Detalles acerca de la comida */
	Comida varchar(500) not null,
	/* Detalles de otros servicios */
	Servicios varchar(500) not null,
	/* Referencia al identificador de la cartelera base para el festival */
	IdCartelera int not null,
	/* Recomendaci�n del chef hecha por el algoritmo */
	IdBanda int not null,
	/* Estado del festival */
	Estado bit not null
)


/*****************************************************/
/**/
alter table Usuario
add constraint FkUsuario_Rol foreign key(IdRol) references Rol(IdRol)
/**/
alter table Usuario
add constraint UniqueCorreo Unique(CorreoElectronico)
/**/
alter table Usuario
add constraint UniqueNUsuario Unique(NombreUsuario)

/*****************************************************/
/**/
alter table DetalleFanatico
add constraint FkDetalleFanatico_Usuario foreign key(IdUsuario) references Usuario(IdUsuario);
/**/
alter table DetalleFanatico
add constraint FkDetalleFanatico_Pais foreign key(IdPais) references Pais(IdPais);

/*****************************************************/
/**/
alter table GeneroXUsuario
add constraint FkGeneroXUsuario_GeneroMusical foreign key(IdGenero) references GeneroMusical(IdGenero)
/**/
alter table GeneroXUsuario
add constraint FkGeneroXUsuario_Usuario foreign key(IdUsuario) references Usuario(IdUsuario)

/*****************************************************/
/**/
alter table Banda
add constraint FkBanda_Genero foreign key(IdGenero) references GeneroMusical(IdGenero)

/*****************************************************/
/**/
alter table MiembroBanda
add constraint FkMiembroBanda_Banda foreign key(IdBanda) references Banda(IdBanda)
/**/
alter table MiembroBanda
add constraint UniqueMiembroXBanda unique(IdMiembroBanda, IdBanda)

/*****************************************************/
/**/
alter table Album
add constraint FkAlbum_Banda foreign key(IdBanda) references Banda(IdBanda)
/**/
alter table Album
add constraint UniqueAlbumXBanda unique(IdAlbum, IdBanda)

/*****************************************************/
/**/
alter table Cancion
add constraint FkCancion_Genero foreign key(IdGenero) references GeneroMusical(IdGenero)
/**/
alter table Cancion
add constraint FkCancion_Banda foreign key(IdBanda) references Banda(IdBanda)
/**/
alter table Cancion
add constraint UniqueCancionBanda unique(IdCancion, IdBanda)

/*****************************************************/
/**/
alter table Comentario
add constraint FkComentario_Usuario foreign key(IdUsuario) references Usuario(IdUsuario)
/**/
alter table Comentario
add constraint FkComentario_Banda foreign key(IdBanda) references Banda(IdBanda)
/**/
alter table Comentario
add constraint UniqueComentarioUsuarioXBanda unique(IdUsuario, IdBanda)

/*****************************************************/
/**/
alter table Cartelera
add constraint FkCartelera_Pais foreign key(IdPais) references Pais(IdPais)

/*****************************************************/
/**/
alter table CategoriaXCartelera
add constraint FkCategoriaXCartelera_Categoria foreign key(IdCategoria) references Categoria(IdCategoria)
/**/
alter table CategoriaXCartelera 
add constraint FkCategoriaXCartelera_Cartelera foreign key(IdCartelera) references Cartelera(IdCartelera)

/*****************************************************/
/**/
alter table BandaXCategoriaXCartelera 
add constraint FkBandaXCategoriaXCartelera_CategoriaXCartelera foreign key(IdCategoriaXCartelera) references CategoriaXCartelera(IdCategoriaXCartelera)
/**/
alter table BandaXCategoriaXCartelera
add constraint FkBandaXCategoriaXCartelera_Banda foreign key(IdBanda) references Banda(IdBanda)

/*****************************************************/
/**/
alter table Festival
add constraint FkFestival_Pais foreign key(IdPais) references Pais(IdPais)
/**/
alter table Festival
add constraint FkFestival_Banda foreign key(IdBanda) references Banda(IdBanda)


/**********************/
/*** PROCEDIMIENTOS ***/
/*** ALMACENADOS    ***/
/**********************/

/* Obtiene todos lo Albumes */
create procedure getAlbumes
	as
	select * from Album
	go

/*Obtener Album por Id*/
create procedure getAlbumById
	@IdAlbum int 
	as 
	select * from Album
	where Album.IdAlbum = @IdAlbum
	go

/* Obtener Album(es) por Nombre */
create procedure getAlbumByNombre
	@NombreAlbum varchar(100)
	as
	select * from Album
	where Album.Nombre = @NombreAlbum
	go

/*  Obtiene la informaci�n de TODOS los �lbumes por el Id de una Banda/Artista */
create procedure getAlbumByIdBanda
	@IdBanda int
	as
	select * from Album
	where Album.IdBanda = @IdBanda
	go

/* Obtiene la informaci�n de TODOS los �lbumes por el Nombre de una Banda/Artista  */
create procedure getAlbumByNombreBanda
	@NombreBanda varchar(100)
	as
	select Album.IdAlbum, Album.Nombre, Album.Imagen, Album.IdBanda, Album.FechaCreacion from Album
	join Banda on Album.IdBanda = Banda.IdBanda
	where Banda.Nombre = @NombreBanda
	go

/* Obtener todas las bandas */
create procedure getBandas
	as
	select * from Banda
	go

/* Obtener banda por Id */
create procedure getBandaById
	@IdBanda int
	as
	select * from Banda
	where Banda.IdBanda = @IdBanda
	go

/* Obtener banda por Nombre */
create procedure getBandaByName
	@NombreBanda varchar(100)
	as 
	select * from Banda 
	where Banda.Nombre = @NombreBanda
	go

/* Obtener Bandas por Id del G�nero Musical */
create procedure getBandaByIdGenero
	@IdGenero int
	as
	select * from Banda
	where Banda.IdGenero = @IdGenero
	go

/* Obtener Bandas por Nombre del G�nero Musical */
create procedure getBandaByNombreGenero
	@NombreGenero varchar(50)
	as
	select Banda.IdBanda, Banda.Nombre, Banda.IdGenero, Banda.PromedioRating from Banda
	join GeneroMusical on Banda.IdGenero = GeneroMusical.IdGenero
	where GeneroMusical.Nombre = @NombreGenero
	go

/* Obtener todas las canciones */
create procedure getCanciones
	as
	select * from Cancion
	go

/* Obtener canci�n por su Id */
create procedure getCancionById
	@IdCancion int
	as
	select * from Cancion
	where Cancion.IdCancion = @IdCancion
	go

/* Obtener canci�n por su nombre */
create procedure getCancionByNombre
	@NombreCancion varchar(100)
	as
	select * from Cancion
	where Cancion.Nombre = @NombreCancion
	go

/* Obtener canciones por id banda */
create procedure getCancionesByIdBanda
	@IdBanda int
	as
	select * from Cancion
	where Cancion.IdBanda = @Idbanda
	go

/* Obtener canciones por nombre de la banda */
create procedure getCancionesByNombreBanda
	@NombreBanda varchar(100)
	as
	select Cancion.IdCancion, Cancion.Nombre, Cancion.Preview, Cancion.Imagen, Cancion.FechaCreacion, 
	Cancion.IdBanda, Cancion.IdGenero, Cancion.IdAlbum, Cancion.Estado from Cancion
	join Banda on Cancion.IdBanda = Banda.IdBanda
	where Banda.Nombre = @NombreBanda
	go

/* Obtener las bandas asignadas a una categor�a mediante el Id de la categor�a y el Id de la cartelera */
create procedure getBandasByIdCategoriaIdCartelera
	@IdCartelera int,
	@IdCategoria int
	as 
	select Banda.IdBanda, Banda.Nombre, Banda.IdGenero, Banda.PromedioRating from Banda
	join (	select * from CategoriaXCartelera
			join BandaXCategoriaXCartelera on CategoriaXCartelera.IdCategoriaXCartelera = BandaXCategoriaXCartelera.IdCategoriaXCartelera
			where CategoriaXCartelera.IdCartelera = 2 and CategoriaXCartelera.IdCategoria = 2) as x
	on Banda.IdBanda = x.IdBanda
	go


	/* Registro */
	alter procedure Registro
		@Nombre varchar(30),
		@Apellido1 varchar(30),
		@Apellido2 varchar(30),
		@Correo varchar(100),
		@NUsuario varchar(30),
		@Contrasena varchar(8),
		@IdRol int,
		@FNacimiento date,
		@IdPais int,
		@Ubicacion varchar(100),
		@Universidad varchar(30),
		@Telefono varchar(15),
		@Foto varchar(max),
		@Descripcion varchar(300)
		as
		begin
		if exists(select * from Usuario where CorreoElectronico = @Correo)
			begin
			/*print 'Correo registrado'*/
			return 101;
			end
		if exists (select * from Usuario where NombreUsuario = @NUsuario)
			begin
			/*print 'NUsuario no disponible'*/
			return 102;
			end
		else
			begin
			if @IdRol = 1
				begin
				insert into Usuario values(@Nombre, @Apellido1, @Apellido2, @Correo, getdate(), @NUsuario,
				@Contrasena, @IdRol, 1, 1);
				/*print 'Admin registrado'*/
				return 100;
				end
			else
				begin
				insert into Usuario values(@Nombre, @Apellido1, @Apellido2, @Correo, getdate(), @NUsuario,
				@Contrasena, @IdRol, 1, 1);
				declare @IdUsuario int
				select @IdUsuario = Usuario.IdUsuario from Usuario
				where Usuario.NombreUsuario = @NUsuario and Usuario.Contrase�a = @Contrasena;
				insert into DetalleFanatico values(@IdUsuario, @FNacimiento, @IdPais, @Ubicacion, @Universidad, 
				@Telefono, @Foto, @Descripcion);
				/*print 'Fan�tico registrado'*/
				return 100;
				end
			end
		end
		go
/*
execute Registro @Nombre = 'Malcolm',
		@Apellido1 = 'Davis',
		@Apellido2 = 'Steele',
		@Correo = 'malcolm.davis@gmail.com',
		@NUsuario = 'malkam03',
		@Contrasena = 'AmoARaven',
		@IdRol = 2,
		@FNacimiento = '1995-03-17',
		@IdPais = 1,
		@Ubicacion = 'Cartago',
		@Universidad = 'ITCR',
		@Telefono = '88888888',
		@Foto = null,
		@Descripcion = 'Persona amigable amante del rap'
*/

/* Login Usuario */
create procedure LoginUsuario
	@Usuario varchar(50),
	@Contrase�a varchar(8)
	as
	begin
	declare @IdUsuario int
	declare @IdRolUsuario int
	declare @SesionActivaUsuario bit
	select @IdUsuario = Usuario.IdUsuario, @IdRolUsuario = Usuario.IdRol, @SesionActivaUsuario = Usuario.SesionActiva from Usuario
	where (Usuario.NombreUsuario = @Usuario or Usuario.CorreoElectronico = @Usuario)
			and Usuario.Contrase�a = @Contrase�a
	if @IdUsuario > 0	
				begin
				if @SesionActivaUsuario = 0
					begin
					update Usuario set SesionActiva = 1
					where IdUsuario = @IdUsuario
					if @IdRolUsuario = 1
						begin
						return 103;
						end
					if @IdRolUsuario = 2
						begin
						return 104;
						end
					end
				else
					begin
					/*print 'El Usuario ya tiene una sesi�n activa'*/
					return 105;
					end
				end
	else
		begin
		/*print 'El Usuario y la contrase�a no coinciden'*/
		return 106;
		end			
	end
	go

/* Cerrar sesi�n de usuario */
create procedure CerrarSesionUsuario
	@IdUsuario int
	as
	begin
	update Usuario set Usuario.SesionActiva = 0
	where Usuario.IdUsuario = @IdUsuario
	end
	go



















/* Obtener el nombre de todos los pa�ses */
create procedure getPais
	as
	select * from Pais
	go

/* Obtener Pa�s por Nombre */
create procedure getPaisByName
	@NombrePais varchar(50)
	as
	select NombrePais from Pais
	where Pais.NombrePais = @NombrePais
	Go

/*Obtener Pa�s por Id */
create procedure getPaisById
	@IdPais int
	as
	select * from Pais
	where Pais.IdPais = @IdPais
	Go




Execute getBandaById @IdBanda = 1


select * from Pais




select * from Usuario