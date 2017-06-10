/* Tabla que almacena los datos compartidos emtre los usuarios (Administradores y Fanáticos) */
Create table Usuario (
	/* Identificador único autoincremental para cada usuario */
	IdUsuario int identity(1,1) primary key,
	/* Nombre del Usuario (Nombre de persona) */
	Nombre varchar(30) not null,
	/* Primer apellido del usuario */
	Apellido1 varchar(30) not null,
	/* Segundo apellido del usuario */
	Apellido2 varchar(30) not null,
	/* Correo Electrónico del usuario */
	CorreoElectronico varchar(50) not null,
	/* Fecha y hora en la que el usuario se está registrando en el sistema */
	FechaInscripcion datetime not null,
	/* Nombre de usuario para el inicio de sesión */
	NombreUsuario varchar(30) not null,
	/* Contraseña del usuario para el inicio de sesión */
	Contraseña varchar(8) not null,
	/* Identificador del rol que tiene el usuario (Administrador o Fanático) referenciado a la tabla Rol */
	IdRol int not null,
	/* Estado del usuario (activo, inactivo) */
	Estado bit not null,
	/* Indicador de una sesión activa en el sistema para un usuario */
	SesionActiva bit not null
)

/* Tabla que especifica los datos adicionales que se guardan para los fanáticos */
Create table DetalleFanatico (
	/* Referencia al identificador único en la tabla Usuario */
	IdUsuario int not null,
	/* Fecha de Nacimiento del fanático */
	FechaNacimiento date not null,
	/* Referencia al identificador único en la tabla Pais */
	IdPais int not null,
	/* Ubicación del Fanático, lugar donde vive */
	Ubicacion varchar(100),
	/* Universidad donde estudia en caso de aplicar */
	Universidad varchar(30),
	/* Número de teléfono del Fanático */
	Telefono varchar(15) not null,
	/* Foto de perfil del Fanático */
	Foto varchar(max), 
	/* Breve descripción personal del fanático */
	DescripcionPersonal varchar(300) not null
)

/* Tabla para los géneros musicales disponibles dentro del sistema */
Create table GeneroMusical (
	/* Identificador único autoincremental para cada género musical */
	IdGenero int identity(1,1) primary key,
	/* Nombre del género musical */
	Nombre varchar(50) not null,
)

/* Tabla que relaciona los géneros musicales que pertenecen a un usuario */
Create table GeneroXUsuario (
	/* Identificador del género musical */
	IdGenero int not null, 
	/* Identificador del usuario */
	IdUsuario  int not null
)

/* Tabla para las bandas/artistas disponibles en el catálogo del sistema */
Create table Banda (
	/* Identificador único autoincremental para cada banda/artista */
	IdBanda int identity(1,1) primary key,
	/* Nombre de la banda/artista */
	Nombre varchar(100) not null,
	/* Promedio de los ratings dados por los fanáticos en sus comentarios */
	PromedioRating int not null,
	/* Identificador del género de la Banda/artista */
	IdGenero int not null
)

/* Tabla para las personas que conforman una banda (miembros) */
Create table MiembroBanda (
	/* Identificador único autoincremental para cada miembro de banda */
	IdMiembroBanda int identity(1,1) primary key,
	/* Nombre del miembro */
	Nombre varchar(100) not null,
	/* Identificador de la banda a la que pertenece */
	IdBanda int not null
)

/* Tabla para los álbumes de las bandas */
Create table Album (
	/* Identificador único autoincremental para el álbum */
	IdAlbum int identity(1,1) primary key,
	/* Nombre del álbum */
	Nombre varchar(100) not null,
	/* Identificador de la banda a la que pertenece el álbum */
	IdBanda int not null,
	/* Imagen del álbum (carátula) */
	Imagen image not null,
	/* Fecha de creación del álbum */
	FechaCreacion datetime not null,
)

Create table Cancion (
	/* Identificador único autoincremental para cada canción */
	IdCancion int identity(1,1) primary key,
	/* Nombre de la canción */
	Nombre varchar(100) not null,
	/* Vínculo del preview de la canción */
	Preview varchar(100) not null,
	/* Imagen de la canción */
	Imagen image not null,
	/* Fecha de creación de la canción */
	FechaCreacion datetime not null,
	/* Identificador de la banda a la que se asocia la canción */
	IdBanda int not null,
	/* Identificador del Género de la canción */
	IdGenero int not null,
	/* Identificador del álbum al que pertenece la canción */
	IdAlbum int not null,
	/* Estado de la canción */
	Estado bit not null
)

Create table Comentario (
	/* Identificador único autoincremental para cada comentario */
	IdComentario int identity(1,1) primary key,
	/* Identificador del usuario que hizo el comentario */
	IdUsuario int not null,
	/* Identificador de la banda al que se le hizo el comentario */
	IdBanda int not null,
	/* Número con el rating que el usuario dió a la banda/artista */
	Rating int not null,
	/* Contenido del comentario */
	Contenido varchar(500) not null,
	/* Feacha en la que se creó el comentario */
	FechaCreacion datetime not null,
	/* Estado del comentario (activo, inactivo) */
	Estado bit not null
)

/* Tabla que almecenará los países que soporta el sistema */
Create table Pais (
	/* Identificador único autoincremental para cada país */
	IdPais int identity(1,1) primary key,
	/* Nombre del país */
	NombrePais varchar(50) not null,
)

/* Tabla que almacenará los roles con los que un usario puede iniciar sesión*/
Create table Rol (
	/* Identificador único autoincremental para cada rol  */
	IdRol int identity(1,1) primary key,
	/* Nombre del Rol */
	NombreRol varchar(50) not null,
	/* Breve descripción del rol */
	Descripcion varchar(500)
)

/* Tabla para las carteleras generadas */
Create table Cartelera (
	/* Identificador único autoincremental para cada cartelera */
	IdCartelera int identity(1,1) primary key,
	/* Nombre de la cartelera */
	Nombre varchar(100) not null,
	/* Referencia al identificador del país donde se va a realizar el país */
	IdPais int not null,
	/* Lugar donde se realizará el posible festival */
	Lugar varchar(100) not null,
	/* Fecha y hora a la cuál las votaciones cerrarán */
	CierreVotacion datetime not null,
	/* Estado de la cartelera */
	Estado bit not null
)

/* Tabla para las categorías disponibles en el sistema */
Create table Categoria (
	/* Identificador único autoincremental para cada categoría */
	IdCategoria int identity(1,1) primary key,
	/* Nombre de la categoría */
	Nombre varchar(100) not null,
	/* Descripción de la categoría */
	Descripcion varchar(500) not null,
	/* Estado de la categoría */
	Estado bit not null
)

/* Tabla para relacionar las categorías con una cartelera */
Create table CategoriaXCartelera (
	/* Identificador único autoincremental para cada registro */
	IdCategoriaXCartelera int identity(1,1) primary key,
	/* Identificador de la categoría */
	IdCategoria int not null,
	/* Identificador de la cartelera */
	IdCartelera int not null
)

/**/
Create table BandaXCategoriaXCartelera (
	/* Referencia al identificador único de un registro en la tabla 
	CategoriaXCartelera de una categoría agregada a una Cartelera */
	IdCategoriaXCartelera int not null,
	/* Referencia al identificador único de una canción en la tabla Cancion */
	IdBanda int not null
)

/* Tabla para los Festivales creados en el sistema */
Create table Festival (
	/* Identificador único autoincremental para cada Festival */
	IdFestival int identity(1,1) primary key,
	/* Nombre del Festival */
	Nombre varchar(100) not null,
	/* Referencia al identificador del país donde se realizará el festival */
	IdPais int not null,
	/* Nombre del lugar donde se hará el festival */
	Lugar varchar(100) not null,
	/* Fecha de Inicio del Festival */
	FechaInicio datetime not null,
	/* Fecha de finalización del festival */
	FechaFinal datetime not null,
	/* Detalles acerca del transporte */
	Transporte varchar(500) not null,
	/* Detalles acerca de la comida */
	Comida varchar(500) not null,
	/* Detalles de otros servicios */
	Servicios varchar(500) not null,
	/* Referencia al identificador de la cartelera base para el festival */
	IdCartelera int not null,
	/* Recomendación del chef hecha por el algoritmo */
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

/*  Obtiene la información de TODOS los Álbumes por el Id de una Banda/Artista */
create procedure getAlbumByIdBanda
	@IdBanda int
	as
	select * from Album
	where Album.IdBanda = @IdBanda
	go

/* Obtiene la información de TODOS los Álbumes por el Nombre de una Banda/Artista  */
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

/* Obtener Bandas por Id del Género Musical */
create procedure getBandaByIdGenero
	@IdGenero int
	as
	select * from Banda
	where Banda.IdGenero = @IdGenero
	go

/* Obtener Bandas por Nombre del Género Musical */
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

/* Obtener canción por su Id */
create procedure getCancionById
	@IdCancion int
	as
	select * from Cancion
	where Cancion.IdCancion = @IdCancion
	go

/* Obtener canción por su nombre */
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

/* Obtener las bandas asignadas a una categoría mediante el Id de la categoría y el Id de la cartelera */
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
				where Usuario.NombreUsuario = @NUsuario and Usuario.Contraseña = @Contrasena;
				insert into DetalleFanatico values(@IdUsuario, @FNacimiento, @IdPais, @Ubicacion, @Universidad, 
				@Telefono, @Foto, @Descripcion);
				/*print 'Fanático registrado'*/
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
	@Contraseña varchar(8)
	as
	begin
	declare @IdUsuario int
	declare @IdRolUsuario int
	declare @SesionActivaUsuario bit
	select @IdUsuario = Usuario.IdUsuario, @IdRolUsuario = Usuario.IdRol, @SesionActivaUsuario = Usuario.SesionActiva from Usuario
	where (Usuario.NombreUsuario = @Usuario or Usuario.CorreoElectronico = @Usuario)
			and Usuario.Contraseña = @Contraseña
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
					/*print 'El Usuario ya tiene una sesión activa'*/
					return 105;
					end
				end
	else
		begin
		/*print 'El Usuario y la contraseña no coinciden'*/
		return 106;
		end			
	end
	go

/* Cerrar sesión de usuario */
create procedure CerrarSesionUsuario
	@IdUsuario int
	as
	begin
	update Usuario set Usuario.SesionActiva = 0
	where Usuario.IdUsuario = @IdUsuario
	end
	go



















/* Obtener el nombre de todos los países */
create procedure getPais
	as
	select * from Pais
	go

/* Obtener País por Nombre */
create procedure getPaisByName
	@NombrePais varchar(50)
	as
	select NombrePais from Pais
	where Pais.NombrePais = @NombrePais
	Go

/*Obtener País por Id */
create procedure getPaisById
	@IdPais int
	as
	select * from Pais
	where Pais.IdPais = @IdPais
	Go




Execute getBandaById @IdBanda = 1


select * from Pais




select * from Usuario