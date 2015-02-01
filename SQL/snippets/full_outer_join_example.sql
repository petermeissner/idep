create table producer 
(
id integer ,
producer varchar(100)
) ;
insert into producer VALUES 
(1,'a'), 
(2,'b'),
(3,'c'),
(4,'d'),
(5,'e'),
(6,'f')
;

create table product 
(
id integer,
product varchar(100),
prod_id integer
);

insert into product VALUES 
(1,'p_a',1), 
(2,'p_b',1),
(3,'p_c',3),
(4,'p_d',4),
(5,'p_e',NULL),
(6,'p_f',NULL)
;



SELECT   a.id, a.producer, b.id as p_id, b.product, prod_id
	FROM producer as a
	LEFT JOIN product as b ON a.id = b.prod_id
UNION
SELECT   a.id, a.producer, b.id as p_id, b.product, prod_id
  FROM producer a
  RIGHT JOIN product b ON a.id = b.prod_id;
