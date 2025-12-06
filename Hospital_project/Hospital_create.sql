create table department (
	dep_id serial primary key,
	dep_name varchar(200)
);

create table doctors (
	doctor_id serial primary key,
	doctor_name varchar(200),
	specialization varchar(200),
	dep_id integer references department(dep_id),
	salary integer
);

create table patients(
	patient_id serial primary key,
	patient_name varchar(200),
	age integer,
	gender char(1) check (gender in ('F', 'M'))
);

create table appointments (
	app_id serial primary key,
	patient_id integer references patients(patient_id),
	doctor_id integer references doctors(doctor_id),
	app_date date,
	status varchar(200)
);


create table treatments (
	treat_id serial primary key,
	app_id integer references appointments(app_id),
	diagnosis varchar(200),
	cost integer
);

create table medications (
	med_id serial primary key,
	treat_id integer references treatments(treat_id),
	med_name varchar(200),
	dose varchar(200)
);

