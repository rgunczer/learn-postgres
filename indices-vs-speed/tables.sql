create table if not exists users(
	id			serial primary key,
	handle 		text not null unique,
	created_at 	timestamptz not null default now()
);

create  table if not exists issues(
	id 			serial primary key,
	user_id		int not null references users(id),
	status		text not null check(status in ('open', 'closed')),
	priority	int not null check(priority between 1 and 5),
	title 		text not null,
	created_at	timestamptz not null default now(),
	updated_at	timestamptz not null default now()
);

create table if not exists comments(
	id			serial primary key,
	issue_id	int not null references issues(id),
	user_id		int not null references users(id),
	body		text not null,
	archived 	boolean not null default false,
	created_at	timestamptz not null default now()
);

/*
drop table "comments";
drop table issues;
drop table users;
*/
