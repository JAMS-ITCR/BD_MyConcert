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
			and Usuario.Contraseña = @Contrasena
	if @IdUsuario != 0	
				begin
				if @SesionActivaUsuario = 1
					begin
					/*print 'El Usuario ya tiene una sesión activa'*/
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
		/*print 'El Usuario y la contraseña no coinciden'*/
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


/* Cerrar sesión de usuario */
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


/* Obtener todos los países */
create procedure getPaises
	as
	begin
	select * from Pais
	end
	go
/*
execute getPais
*/

/* Obtenere todos los géneros musicales */
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
	if exists (select * from Cartelera where Cartelera.Nombre = @Nombre)
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

/* Asignar una Banda a Una categoría que fue asignada a una cartelera */
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
					insert into BandaXCategoriaXCartelera values(@IdCategoria, @IdCartelera)
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
	@IdGenero int
	as
	begin
	if not exists(select * from Banda where Banda.Nombre = @NBanda)
		begin
		if exists (select * from GeneroMusical where IdGenero = @IdGenero)
			begin
			begin try
			insert into Banda values(@NBanda, 0,@IdGenero)
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

/* Asignar Miembros a una Banda */



/* Obtener todas las Bandas */
create procedure getBandas
	@IdBanda int
	



/* Obtener las categorías y las bandas por Nombre de Cartelera
create procedure getBandasXCategoriaXCartelera
	@NCartelera varchar(100)
	as
	begin
	declare @IdCartelera int
	select @IdCartelera = Cartelera.IdCartelera from Cartelera where Cartelera.Nombre = @NCartelera
	if @IdCartelera > 0
		begin
		select IdCartelera, Categoria.IdCategoria, Categoria.Nombre, Banda.IdBanda, Banda.Nombre, Acumulado from 
		(Categoria join 
		(CategoriaXCartelera join 
		(BandaXCategoriaXCartelera join Banda on BandaXCategoriaXCartelera.IdBanda = Banda.IdBanda) 
		on CategoriaXCartelera.IdCategoriaXCartelera = BandaXCategoriaXCartelera.IdCategoriaXCartelera)
		on Categoria.IdCategoria = CategoriaXCartelera.IdCategoria)
		where CategoriaXCartelera.IdCartelera = @IdCartelera
		end
	else
		return 106;
	end
	go

	declare @result int
	exec @result = getBandasXCategoriaXCartelera 'Rock Imperial'
	select @result*/


/* Realizar Votación */
alter procedure HacerVotacion
	@data nvarchar(max)
	as
	begin
	if @data != ''
		begin
		begin try
		insert into ControlVotaciones(IdCategoriaXCartelera, IdBanda, IdUsuario, Monto)
		select IdCategoriaXCartelera, IdBanda, IdUsuario, Monto
		from openjson(@data)
		with (IdCategoriaXCartelera int, IdBanda int, IdUsuario int, Monto int)
		return 100;
		end try

		begin catch 
		return 102;
		end catch
		end
	else
		return 101
	end
	go
