create database Activida;
use Activida;

create table usuario(
	id int primary key auto_increment,
    nombre varchar(100) not null,
    email varchar(100) unique not null,
    telefeno varchar(100),
    dirrecion varchar(100) not null
);
create table restaurantes(
id int primary key auto_increment,
nombre varchar(100) not null,
direccion varchar(255) not null unique,
telefono varchar(20) not null
);

create table productos(
id int primary key auto_increment,
restaurante_id int not null,
nombre varchar(100) not null,
descripcion text,
precio decimal (10,2) not null,
foreign key (restaurante_id) references restaurantes(id)
);
create table pedidos(
id int primary key auto_increment,
usuario_id int not null,
restaurante_id int not null,
fecha timestamp default current_timestamp,
estado varchar(50) default 'pendiente',
foreign key (usuario_id) references usuario(id),
foreign key (restaurante_id) references restaurantes(id)
);

create table detalle_pedido(
id int primary key auto_increment,
pedido_id int not null,
producto_id int not null,
cantidad int not null,
precio_unitario decimal(10,2) not null,
foreign key (pedido_id) references pedidos(id),
foreign key (producto_id) references productos(id)
);