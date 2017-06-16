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
				begin try
				insert into Usuario values(@Nombre, @Apellido1, @Apellido2, @Correo, getdate(), @NUsuario,
				@Contrasena, @IdRol, 1, 1);
				/*print 'Admin registrado'*/
				return 100;
				end try
				begin catch
				return 103;
				end catch
				end
			else
				begin
				begin try
				insert into Usuario values(@Nombre, @Apellido1, @Apellido2, @Correo, getdate(), @NUsuario,
				@Contrasena, @IdRol, 1, 1);
				declare @IdUsuario int
				select @IdUsuario = Usuario.IdUsuario from Usuario
				where Usuario.NombreUsuario = @NUsuario and Usuario.Contrase�a = @Contrasena;
				insert into DetalleFanatico values(@IdUsuario, @FNacimiento, @IdPais, @Ubicacion, @Universidad, 
				@Telefono, @Foto, @Descripcion);
				/*print 'Fan�tico registrado'*/
				return 100;
				end try
				begin catch
				return 103;
				end catch
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
alter procedure LoginUsuario
	@Usuario varchar(50),
	@Contrasena varchar(8)
	as
	begin
	declare @IdUsuario int
	declare @IdRolUsuario int
	declare @SesionActivaUsuario bit
	declare @Retorno int
	select @IdUsuario = Usuario.IdUsuario, @IdRolUsuario = Usuario.IdRol, @SesionActivaUsuario = Usuario.SesionActiva from Usuario
	where (Usuario.NombreUsuario = @Usuario or Usuario.CorreoElectronico = @Usuario)
			and Usuario.Contrase�a = @Contrasena
	if @IdUsuario != 0	
				begin
				if @SesionActivaUsuario = 1
					begin
					/*print 'El Usuario ya tiene una sesi�n activa'*/
					set @Retorno = 105
					end
				if @SesionActivaUsuario = 0
					begin
					update Usuario set SesionActiva = 1
					where IdUsuario = @IdUsuario
					if @IdRolUsuario = 1
						begin
						set @Retorno = 103;
						end
					if @IdRolUsuario = 2
						begin
						set @Retorno = 104;
						end
					end
				end
	else
		begin
		/*print 'El Usuario y la contrase�a no coinciden'*/
		set @Retorno = 106;
		end	
	return @Retorno;		
	end
	go

declare @resultado int

execute @resultado = LoginUsuario
                @Usuario = 'Teby',
                @Contrasena = 'AmoAOMI'
select @resultado

select * from Usuario


/* Cerrar sesi�n de usuario */
alter procedure CerrarSesionUsuario
	@NUsuario varchar(30)
	as
	begin
	declare @Sesion bit
	select @Sesion = SesionActiva from Usuario where Usuario.NombreUsuario = @NUsuario
	print @NUsuario
	if exists(select * from Usuario where Usuario.NombreUsuario = @NUsuario)
		begin
			if @Sesion = 1
				begin
				update Usuario set Usuario.SesionActiva = 0
				where Usuario.NombreUsuario = @NUsuario
				print 'Exito'
				return 100;
				end
			else if @Sesion = 0
				begin
				print 'Usuario con Sesion no activa'
				return 101;
				end
		end
	else
		begin
		print 'Usuario no existe'
		return 102
		end
	end
	go

	declare @resultado int 
	execute @resultado = CerrarSesionUsuario
                @NUsuario = 'Teby'
	select @resultado

	select * from Usuario


/* Obtener todos los pa�ses */
create procedure getPaises
	as
	begin
	select * from Pais
	end
	go
/*
execute getPais
*/

/* Obtenere todos los g�neros musicales */
create procedure getGeneros
	as
	begin
	select * from GeneroMusical
	end
	go

/* Crear Cartelera */
create procedure crearCartelera 
	@Nombre varchar(100),
	@IdPais int,
	@Lugar varchar(100),
	@CierreVotacion datetime,
	@FechaInicio datetime,
	@FechaFinal datetime,
	@Estado bit
	as
	begin
	if not exists (select * from Cartelera where Cartelera.Nombre = @Nombre)
		begin
		begin try
		insert into Cartelera values(@Nombre, @IdPais, @Lugar, @CierreVotacion, @FechaInicio, @FechaFinal, @Estado)
		return 100;
		end try
		begin catch
		return 101;
		end catch
		end
	else
		return 102;
	end
	go

/* Asignar una Categoria a una Cartelera */
create procedure asignarCategoriaCartelera
	@IdCategoria int,
	@IdCartelera int
	as
	begin
	if exists (select * from Categoria where Categoria.IdCategoria = @IdCategoria)
		begin
		if exists(select * from Cartelera where Cartelera.IdCartelera = @IdCartelera)
			begin 
			begin try
			insert into CategoriaXCartelera values(@IdCategoria, @IdCartelera)
			return 100;
			end try
			begin catch
			return 101;
			end catch
			end
		else
			return 102;
		end
	else
		return 103;
	end
	go

/* Asignar una Banda a Una categor�a que fue asignada a una cartelera */
create procedure asignarBandaCategoriaCartelera
	@IdCategoria int,
	@IdCartelera int,
	@IdBanda int
	as
	begin
	if exists (select * from Categoria where Categoria.IdCategoria = @IdCategoria)
		begin
		if exists(select * from Cartelera where Cartelera.IdCartelera = @IdCartelera)
			begin 
			if exists(select * from Banda where Banda.IdBanda = @IdBanda)
				begin
				declare @IdCategoriaXCartelera int
				select @IdCategoriaXCartelera = IdCategoriaXCartelera from CategoriaXCartelera 
				where CategoriaXCartelera.IdCartelera = @IdCartelera and CategoriaXCartelera.IdCategoria = @IdCategoria
				if @IdCategoriaXCartelera > 0
					begin
					begin try
					insert into BandaXCategoriaXCartelera values(@IdCategoriaXCartelera, @IdBanda, 0)
					return 100;
					end try
					begin catch
					return 101;
					end catch
					end
				else
					return 105
				end
			else
				return 104;
			end
		else
			return 102;
		end
	else
		return 103;
	end
	go


	
/* Obtener todas las Carteleras */
create procedure getCarteleras
	as
	begin
	select * from Cartelera
	end
	go

/* Obtener todas las Carteleras Activas */
create procedure getCartelerasActivas
	as
	begin
	select * from Cartelera
	where Cartelera.Estado = 1
	end
	go


/* Obtener detalles de la cartelera */
create procedure getDetalleCartelera
	@IdCartelera int
	as
	begin
	if exists (select * from Cartelera where IdCartelera = @IdCartelera)
		begin
		select * from Cartelera 
		where IdCartelera = @IdCartelera
		end  
	else
		return 101;
	end
	go


/* Obtener todos los Festivales */
create procedure getFestivales
	as
	begin
	select * from Festival
	end
	go


/* Obtener detalle de festival */
create procedure getDetalleFestival
	@IdFestival int
	as
	begin
	if exists (select * from Festival where IdFestival = @IdFestival)
		begin
		select IdFestival, Festival.Nombre, IdPais, Lugar, FechaInicio, FechaFinal, Transporte, Comida, Servicios, IdBanda, Festival.Estado from Festival 
		join Cartelera on Festival.IdCartelera = Cartelera.IdCartelera
		where Festival.IdCartelera = @IdFestival
		end  
	else
		return 101;
	end
	go

/* Crear banda */
create procedure crearBanda
	@NBanda varchar(100),
	@IdGenero int,
	@Descripcion varchar(300)
	as
	begin
	if not exists(select * from Banda where Banda.Nombre = @NBanda)
		begin
		if exists (select * from GeneroMusical where IdGenero = @IdGenero)
			begin
			begin try
			insert into Banda values(@NBanda,@IdGenero, @Descripcion)
			return 100;
			end try
			begin catch
			return 101
			end catch
			end
		else
			begin
			return 102;
			end
		end
	else
		return 103;
	end
	go

/* Actualizar una Banda */
create procedure updateBanda
	@IdBanda int,
	@Descripcion varchar(300),
	@Estado bit
	as
	begin
	if exists(select * from Banda where IdBanda = @IdBanda)
		begin
		begin try
		update Banda set DescripcionBanda = @Descripcion, Estado = @Estado where IdBanda = @IdBanda
		return 100;
		end try
		begin catch 
		return 101;
		end catch
		end
	else
		return 102;
	end
	go

	/* Actualizar el estado de la banda */
create procedure updateEstadoBanda 
	@IdBanda int,
	@Estado bit
	as
	begin
	if exists(select * from Banda where IdBanda = @IdBanda)
		begin
		begin try
		update Banda set Estado = @Estado where IdBanda = @IdBanda
		return 100;
		end try
		begin catch
		return 101;
		end catch
		end
	else
		return 102;
	end
	go





/* Obtener todas las Bandas */
create procedure getBandas
	as
	begin
	select * from Banda
	end
	go
	

/* Obtener banda mediante Id */
create procedure getBandaById
	@IdBanda int
	as
	begin
	if exists(select * from Banda where Banda.IdBanda = @IdBanda)
		begin
		select * from Banda where Banda.IdBanda = @IdBanda
		end
	else
		return 101;
	end 
	go

/* Asignar miembro a una Banda */
create procedure asignarMiembroBanda
	@NMiembro varchar(100),
	@IdBanda int
	as
	begin
	if exists(select * from Banda where Banda.IdBanda = @IdBanda)
		begin
		begin try
		insert into MiembroBanda values(@NMiembro, @IdBanda)
		return 100;
		end try
		begin catch
		return 101;
		end catch
		end
	else
		return 102;
	end
	go

/* Eliminar un miembro de una banda */
create procedure eliminarMiembroBanda
	@IdBanda int,
	@IdMiembro
	as
	begin
	if exists(select * from Banda where IdBanda = @IdBanda)
		begin
		if exists(select * from MiembroBanda where IdMiembroBanda = @IdMiembro)
			begin
			begin try
			delete from MiembroBanda where IdMiembroBanda = @IdMiembro
			return 100;
			end try
			begin catch
			return 101;
			end catch
			end
		else
			return 102;
		end
	else
		return 103;
	end
	go


/* Obtener todos los miembros de una Banda */
create procedure getMiembrosByBandaId
	@IdBanda int
	as
	begin
	if exists (select * from Banda where IdBanda = @IdBanda)
		begin
		if exists (select * from MiembroBanda where IdBanda = @IdBanda)
			begin
			select * from MiembroBanda where IdBanda = @IdBanda
			end
		return 102;
		end
	else
		return 101;
	end
	go

/* Agregar una imagen a una Banda */
create procedure addImagenBanda 
	@IdBanda int,
	@UrlImagen varchar(200)
	as
	begin
	if exists (select * from Banda where IdBanda = @IdBanda)
		begin
		if not exists (select * from ImagenBanda where UrlImagen = @UrlImagen)
			begin
			begin try 
			insert into ImagenBanda values(@IdBanda, @UrlImagen)
			return 100;
			end try
			begin catch
			return 101;
			end catch
			end
		else
			return 103;
		end
	else
		return 102;
	end 
	go

/* Eliminar una imagen de una banda */
create procedure eliminarImagenBanda 
	@IdBanda int,
	@IdImagen int
	as
	begin
	if exists (select * from Banda where IdBanda = @IdBanda)
		begin
		if exists (select * from ImagenBanda where IdImagenBanda = @IdImagen and IdBanda = @IdBanda)
			begin
			begin try
			delete from ImagenBanda where IdImagenBanda = @IdImagen and IdBanda = @IdBanda
			return 100;
			end try
			begin catch
			return 101;
			end catch
			end
		else
			return 102;
		end
	else
		return 103;
	end
	go

/* A�adir una canci�n  a una banda */
create procedure addCancionBanda
	@NCancion varchar(100),
	@Preview varchar(100),
	@Imagen nvarchar(max),
	@IdBanda int,
	@IdAlbum int,
	@Estado bit
	as
	begin
	if exists (select * from Banda where IdBanda = @IdBanda)
		begin
		if not exists (select * from Cancion where IdBanda = @IdBanda and Nombre = @NCancion)
			begin
			begin try
			insert into Cancion values(@NCancion, @Preview, @Imagen, @IdBanda, @IdAlbum, 1)
			return 100;
			end try
			begin catch
			return 101;
			end catch
			end
		else
			return 102;
		end
	else
		return 103;
	end
	go

/* Eliminar una canci�n de una Banda */
create procedure eliminarCancionBanda
	@IdBanda int,
	@IdCancion int
	as
	begin
	if exists(select * from Banda where IdBanda = @IdBanda)
		begin
		if exists(select * from Cancion where IdBanda = @IdBanda and IdCancion = @IdCancion)
			begin
			begin try
			delete from Cancion where IdBanda = @IdBanda and IdCancion = @IdCancion
			return 100;
			end try
			begin catch
			return 101;
			end catch
			end
		else
			return 102;
		end
	else
		return 103;
	end go


/* Obtener el rating promedio de una banda dado por los fan�ticos */
alter procedure getRatingBanda
	@IdBanda int
	as
	begin
	if exists (select * from Banda where IdBanda = @IdBanda)
		begin
		if (select avg(Rating) from Comentario where IdBanda = @IdBanda) != 0
			begin
			select avg(Rating) as Rating from Comentario where IdBanda = @IdBanda
			end
		else
			return 102;
		end
	else
		return 101;
	end
	go

/* Obtener Acumulado */
create procedure getAcumuladoBanda
	@IdBanda int
	as
	begin
	if exists (select * from Banda where IdBanda = @IdBanda)
		begin
		select sum(Monto) from ControlVotaciones where IdBanda = @IdBanda
		end
	else
		return 101
	end
	go


/* Crear comentario */
create procedure crearComentario
	@IdUsuario int,
	@IdBanda int,
	@Rating int,
	@Contenido varchar(500)
	as
	begin
	if exists (select * from Usuario where Usuario.IdUsuario = @IdUsuario)
		begin
		if exists (select * from Banda where Banda.IdBanda = @IdBanda)
			begin
			if 0 < @Rating and @Rating < 5
				begin
				begin try
				insert into Comentario values (@IdUsuario, @IdBanda, @Rating, @Contenido, getdate(), 1)
				return 100;
				end try
				begin catch
				return 101;
				end catch
				end
			else
				return 104;
			end
		else
			return 102;
		end
	else
		return 103;
	end
	go

	/* Obtener todos los comentarios para una banda by Id */
create procedure getComentariosBanda 
	@IdBanda int
	as
	begin
	if exists (select * from Banda where Banda.IdBanda = @IdBanda)
		begin
		select * from Comentario where IdBanda = @IdBanda
		end
	else
		return 101;
	end
	go

/* Obtener las categor�as y las bandas por Nombre de Cartelera*/
alter procedure getBandasXCategoriaXCartelera
	@IdCartelera int
	as
	begin
	if exists (select * from Cartelera where IdCartelera = @IdCartelera)
		begin
		if exists(select * from CategoriaXCartelera where IdCartelera = @IdCartelera)
			begin
			begin try
			select IdCartelera, Categoria.IdCategoria, Categoria.Nombre as NombreCategoria, Banda.IdBanda, Banda.Nombre as BandaNombre, Acumulado from 
			(Categoria join 
			(CategoriaXCartelera join 
			(BandaXCategoriaXCartelera join Banda on BandaXCategoriaXCartelera.IdBanda = Banda.IdBanda) 
			on CategoriaXCartelera.IdCategoriaXCartelera = BandaXCategoriaXCartelera.IdCategoriaXCartelera)
			on Categoria.IdCategoria = CategoriaXCartelera.IdCategoria)
			where CategoriaXCartelera.IdCartelera = @IdCartelera
			end try
			begin catch
			return 103;
			end catch
			end
		else
			return 101;
		end
	else
		return 102;
	end
	go


/* Realizar Votaci�n */
alter procedure HacerVotacion
	@data nvarchar(max)
	as
	begin
	if @data != ''
		begin
		begin try
		begin transaction T1;
		insert into ControlVotaciones(IdCategoriaXCartelera, IdBanda, IdUsuario, Monto)
		select IdCategoriaXCartelera, IdBanda, IdUsuario, Monto
		from openjson(@data)
		with (IdCategoriaXCartelera int, IdBanda int, IdUsuario int, Monto int)
		return 100;
		commit transaction T1;
		end try

		begin catch 
		return 102;
		end catch
		end
	else
		return 101
	end
	go

/* Obtener la informaci�n de un usuario */
create procedure getInfoUsuario
	@IdUsuario int,
	@IdRol int
	as
	begin
	if exists (select * from Usuario where IdUsuario = @IdUsuario)
		begin 
		if exists (select * from Rol where IdRol = @IdRol)
			begin
			if exists (select * from Usuario where IdUsuario = @IdUsuario and IdRol = @IdRol)
				begin
				select * from Usuario where IdUsuario = @IdUsuario and IdRol = @IdRol
				end
			else
				return 101;
			end
		else
			return 102;
		end
	else
		return 103;
	end
	go

/* Obtener el detalle de un fan�tico */
create procedure getDetalleFanatico
	@IdUsuario int
	as
	begin
	if exists (select * from Usuario where IdUsuario = @IdUsuario)
		begin 
		if exists (select * from Usuario where IdUsuario = @IdUsuario and IdRol = 2)
			begin
			select * from Usuario where IdUsuario = @IdUsuario and IdRol = 2
			end
		else
			return 101;
		end
	else
		return 102;
	end
	go

/* Asignar g�neros a un fanatico */
create procedure asignarGeneroFanatico
	@IdUsuario int,
	@IdGenero int 
	as
	begin
	if exists (select * from Usuario where IdUsuario = @IdUsuario and IdRol = 2)
		begin
		if exists(select * from GeneroMusical where IdGenero = @IdGenero)
			begin
			begin try
			insert into GeneroXUsuario values(@IdGenero, @IdUsuario)
			return 100;
			end try
			begin catch
			return 101;
			end catch
			end
		else
			return 102;
		end
	else
		return 103;
	end
	go


	/* Obtener los g�neros de un fan�tico */
create procedure getGenerosFanatico
	@IdUsuario int
	as
	begin
	if exists(select * from Usuario where IdUsuario = @IdUsuario)
		begin
		select * from GeneroXUsuario where IdUsuario = @IdUsuario
		end
	else
		return 101;
	end
	go


/* Obtener genero por Id */
create procedure getGeneroById
	@IdGenero int
	as
	begin
	if exists(select * from GeneroMusical where IdGenero = @IdGenero)
		begin
		select * from GeneroMusical where IdGenero = @IdGenero
		end
	else
		return 101;
	end

/* Obtener bandas por categoria y cartelera */
create procedure getBandaXCategoriaXCartelera
	@IdCategoria int,
	@IdCartelera int
	as
	begin
	declare @IdCategoriaXCartelera int
	select @IdCategoriaXCartelera = IdCategoriaXCartelera from CategoriaXCartelera where IdCategoria = @IdCategoria and IdCartelera = @IdCartelera
	if exists(select * from Cartelera where IdCartelera = @IdCartelera)
		begin
		if exists(select * from Categoria where IdCategoria = @Idcategoria)
			begin
			if @IdCategoriaXCartelera > 0
				begin
				select Banda.IdBanda, Acumulado, Nombre from (BandaXCategoriaXCartelera join Banda on Banda.IdBanda = BandaXCategoriaXCartelera.IdBanda) 
				where IdCategoriaXCartelera = @IdCategoriaXCartelera
				end
			else
				return 103;
			end
		else
			return 101;
		end
	else
		return 102;
	end
	go

