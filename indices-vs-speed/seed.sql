begin;

insert into users(handle, created_at)
select
	format('user_%s_%s', gs, substr(md5(random()::text), 1, 6)) as handle,
	now() - (random() * interval '365 days') as created_at
from generate_series(1, 100) as gs;

--select random();
--select random(), gs from generate_series(1,10) as gs;

select 1 + floor(random() * 100) from generate_series(1, 10);

insert into issues(user_id, status, priority, title, created_at, updated_at)
select
	(1 + floor(random() * 100))::bigint as user_id,
	case when random() < 0.65 then 'open' else 'closed' end as status,
	(1 + floor(random() * 5))::int as priority,
	format('Issue #%s - %s', gs, substr(md5(random()::text), 1, 10)) as title,
	(now() - (random() * interval '365 days')) as created_at,
	(now() - (random() * interval '365 days')) + (random() * interval '30 days') as updated_at
from generate_series(1, 10000) as gs;


insert into comments(issue_id, user_id, body, archived, created_at)
select
	(1 + floor(random() * 10000))::bigint as issue_id,
	(1 + floor(random() * 100))::bigint as user_id,
	format('Comment %s: %s', gs, substr(md5(random()::text), 1, 32)) as body,
	(random() < 0.01) as archived,
	(now() - (random() * interval '365 days')) as created_at
from generate_series(1, 1000000) as gs;

commit;

-- rollback;

-- select count(*) from users;
-- select count(*) from issues;
-- select count(*) from comments;




