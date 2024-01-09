create table p_categories (
	id uuid primary key,
	title varchar(200)
);

create table p_products (
	id uuid primary key,
	category_id uuid,
	title varchar(1000),
	short_description varchar,
	description text,
	preview varchar,
	price float,
	discount int,
	is_active bool,
	created timestamp with time zone,
	constraint product_category_fk foreign key (category_id) references p_categories(id)
);

create table p_tags (
	id uuid primary key,
	title varchar(100)
);

create table p_product_tags (
	product_id uuid,
	tag_id uuid,
	constraint product_tags_product_fk foreign key (product_id) references p_products(id),
	constraint product_tags_tag_fk foreign key (tag_id) references p_tags(id)
);

create table p_sizes (
	id uuid primary key,
	title varchar(100),
	label varchar(10),
	position smallint
);

create table p_product_sizes (
	product_id uuid,
	size_id uuid,
	constraint product_sizes_product_fk foreign key (product_id) references p_products(id),
	constraint product_sizes_size_fk foreign key (size_id) references p_sizes(id)
);

create table p_blog_posts (
	id uuid primary key,
	title varchar(1000),
	description text,
	content text,
	image varchar(100),
	created timestamp with time zone
);

create table p_product_images (
	id uuid primary key,
	product_id uuid,
	image varchar(100),
	constraint product_images_image_fk foreign key (product_id) references p_products(id)
);

create table p_cities (
	id uuid primary key,
	title varchar(100)
);

create table p_shipping_addresses (
	id uuid primary key,
	city_id uuid,
	zip varchar(10),
	address varchar,
	constraint shipping_address_city_fk foreign key (city_id) references p_cities(id)
);

create table p_user_info (
	id uuid primary key,
	first_name varchar(100),
	last_name varchar(100),
	email varchar(100),
	phone varchar(20)
);

create table p_users (
	id uuid primary key,
	login varchar (100),
	password varchar(100),
	image varchar(100),
	address_id uuid,
	info_id uuid,
	role_id smallint,
	created timestamp with time zone,
	constraint users_address_fk foreign key (address_id) references p_shipping_addresses(id),
	constraint users_info_fk foreign key (info_id) references p_user_info(id)
);

create table p_user_addresses (
	user_id uuid,
	address_id uuid,
	constraint user_addresses_user_fk foreign key (user_id) references p_users(id),
	constraint user_addresses_address_fk foreign key (address_id) references p_shipping_addresses(id)
);

create table p_reviews (
	id uuid primary key,
	user_id uuid,
	product_id uuid,
	name varchar(100),
	description text,
	score smallint,
	created timestamp with time zone,
	constraint reviews_user_fk foreign key (user_id) references p_users(id),
	constraint reviews_product_fk foreign key (product_id) references p_products(id)
);

create table p_orders (
	id uuid primary key,
	user_id uuid,
	state smallint,
	order_number varchar(100),
	user_info_id uuid,
	address_id uuid,
	total decimal,
	shipping decimal,
	payment_method smallint,
	description varchar,
	created timestamp with time zone,
	updated timestamp with time zone,
	constraint orders_user_fk foreign key (user_id) references p_users(id),
	constraint orders_user_info_fk foreign key (user_info_id) references p_user_info(id),
	constraint orders_address_fk foreign key (address_id) references p_shipping_addresses(id)
);

create table p_order_items (
	id uuid primary key,
	order_id uuid,
	product_id uuid,
	size_id uuid,
	amount smallint,
	price decimal,
	constraint order_item_order_fk foreign key (order_id) references p_orders(id),
	constraint order_item_product_fk foreign key (product_id) references p_products(id),
	constraint order_item_size_fk foreign key (size_id) references p_sizes(id)
);

-------------------------------------------------------------------------------------------------

insert into p_cities values ('a7a7a228-cb5d-4529-9614-34fed3c1e11c'::uuid, 'Minsk');
insert into p_cities values ('50c9a883-7ab5-4e1b-b53f-a941755936f3'::uuid, 'Grodno');
insert into p_cities values ('ca586be9-0b30-44a0-a8f2-42c7052ccc6d'::uuid, 'Vitebsk');
insert into p_cities values ('d5aa92dd-476c-4f6a-b8a0-c82550ee643d'::uuid, 'Mogilev');
insert into p_cities values ('f5226404-bfad-4130-9891-db8d2af3b58f'::uuid, 'Gomel');
insert into p_cities values ('9fa2e26e-b212-46fb-9d8b-48bb05070c31'::uuid, 'Brest');

insert into p_categories values ('9318bc50-4e54-4eef-a011-b845021a28df'::uuid, 'Bonsai');
insert into p_categories values ('1b4c2b82-0b5f-460a-8d0f-2d7492c083ba'::uuid, 'Cacti & Succulents');
insert into p_categories values ('81de93ac-8998-4a98-8fa2-070947b04569'::uuid, 'Ferns');
insert into p_categories values ('603b4d36-4feb-43a6-8f7d-64af5e471224'::uuid, 'Flowering');
insert into p_categories values ('422eb639-56a2-41d8-91bf-b8e738b83f38'::uuid, 'Foliage');
insert into p_categories values ('52561f14-9de0-4200-a8f7-e1b2344272a1'::uuid, 'Indoor Trees');
insert into p_categories values ('c52df8cf-1725-44c2-8105-e2cbe03deeab'::uuid, 'Orchids');
insert into p_categories values ('63fa4d1d-95a6-49c7-a18d-25015bfb0f48'::uuid, 'Patterned');
insert into p_categories values ('ae11cf72-8258-449c-85b3-b5cd7bdf9d6b'::uuid, 'Terrariums');

insert into p_tags values ('fd48d4d9-6236-4706-b0cf-c4d431d9d3ef'::uuid, 'Home');
insert into p_tags values ('6b8c8e0e-1457-4cfd-99f3-89148b6cde40'::uuid, 'Garden');
insert into p_tags values ('61fb6955-ceb2-4c71-952d-88e622bd9630'::uuid, 'Pet-Friendly');

insert into p_sizes values ('8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid, 'Small', 'S');
insert into p_sizes values ('b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid, 'Medium', 'M');
insert into p_sizes values ('2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid, 'Large', 'L');
insert into p_sizes values ('7d3fd60b-154a-4499-8bfa-11531a025f5e'::uuid, 'Extra Large', 'XL');

insert into p_tags values ('ce0325b5-0556-4fd0-a821-703629ed4051'::uuid, 'Bonsai');
insert into p_tags values ('6c39522a-f5f5-4454-8f32-b6aecdc400a6'::uuid, 'Bedroom Plants');
insert into p_tags values ('99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid, 'Kitchen Plants');
insert into p_tags values ('f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid, 'Living Room Plants');
insert into p_tags values ('49fb041e-6bd9-481e-af34-caf67ba92bfb'::uuid, 'Study Plants');
insert into p_tags values ('daaefefe-99c7-4c94-8f30-9ee0ea27b4dd'::uuid, 'Cacti & Succulents');
insert into p_tags values ('e8766334-b054-4955-988c-51311131a3fd'::uuid, 'Indoor Ferns');
insert into p_tags values ('53f762cc-2232-4c41-849d-940f133c9d46'::uuid, 'Bathroom Plants');
insert into p_tags values ('04dcf3fd-3c1a-4402-905f-1fd4332e211e'::uuid, 'Flowering Indoor Plants');
insert into p_tags values ('de66b522-8014-4cf2-af54-bf2bdec6cb46'::uuid, 'Foliage');
insert into p_tags values ('ce6c2213-4a6b-490c-a110-0c636a864a23'::uuid, 'Hallway Plants');
insert into p_tags values ('b4e768f3-aa04-47ff-bf34-70c2cfc31421'::uuid, 'Patterned Plants');
insert into p_tags values ('b1f7fac1-5de2-4aeb-9448-f145477370cc'::uuid, 'Indoor Trees');
insert into p_tags values ('efd65ef6-f4ed-4c00-add7-896f969e764e'::uuid, 'Indoor Palms');
insert into p_tags values ('febe149d-050f-419a-97a2-1a25616c8e9f'::uuid, 'Terrarium Plants');

-- PRODUCTS --

insert into p_products values (
'54e6a1e2-d6d6-4bad-a3a6-a3612ff045aa'::uuid,
'9318bc50-4e54-4eef-a011-b845021a28df'::uuid,
'Bonsai Money Tree',
'The Bonsai Money Tree or Pachira aquatica houseplant is a striking indoor tree originating from tropical wetlands. Elegant green leaves dangle from its thick bulbous, trunk stem. This easy-care indoor plant is perfect situated on a countertop, table or as an office companion. According to feng shui, it is also said to bring prosperity and good fortune. We''ve also got a money tree with a braided stem here.',
'Pachira aquatica or money tree houseplants are native to tropical Central and South America. They have also become culturally important plants in Asia, where they are held in high regard due to their palmate leaves. They have become increasingly popular in recent years as an indoor tree.' || chr(10) ||
'The name "money tree" is believed to refer to a story of its origin, in which a poor man prayed for money, found this "odd" plant, took it home as an omen and made money selling plants grown from its seeds.',
'54e6a1e2-d6d6-4bad-a3a6-a3612ff045aa_0.webp',
12,
null,
true,
current_timestamp);
insert into p_product_sizes values ('54e6a1e2-d6d6-4bad-a3a6-a3612ff045aa'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_sizes values ('54e6a1e2-d6d6-4bad-a3a6-a3612ff045aa'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('54e6a1e2-d6d6-4bad-a3a6-a3612ff045aa'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '54e6a1e2-d6d6-4bad-a3a6-a3612ff045aa'::uuid, '54e6a1e2-d6d6-4bad-a3a6-a3612ff045aa_0.webp');
insert into p_product_images values (uuid_generate_v4(), '54e6a1e2-d6d6-4bad-a3a6-a3612ff045aa'::uuid, '54e6a1e2-d6d6-4bad-a3a6-a3612ff045aa_1.webp');
insert into p_product_images values (uuid_generate_v4(), '54e6a1e2-d6d6-4bad-a3a6-a3612ff045aa'::uuid, '54e6a1e2-d6d6-4bad-a3a6-a3612ff045aa_2.webp');
insert into p_product_images values (uuid_generate_v4(), '54e6a1e2-d6d6-4bad-a3a6-a3612ff045aa'::uuid, '54e6a1e2-d6d6-4bad-a3a6-a3612ff045aa_3.webp');
insert into p_product_tags values ('54e6a1e2-d6d6-4bad-a3a6-a3612ff045aa'::uuid, 'ce0325b5-0556-4fd0-a821-703629ed4051'::uuid);
insert into p_product_tags values ('54e6a1e2-d6d6-4bad-a3a6-a3612ff045aa'::uuid, '6c39522a-f5f5-4454-8f32-b6aecdc400a6'::uuid);
insert into p_product_tags values ('54e6a1e2-d6d6-4bad-a3a6-a3612ff045aa'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);
insert into p_product_tags values ('54e6a1e2-d6d6-4bad-a3a6-a3612ff045aa'::uuid, 'f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid);
insert into p_product_tags values ('54e6a1e2-d6d6-4bad-a3a6-a3612ff045aa'::uuid, '49fb041e-6bd9-481e-af34-caf67ba92bfb'::uuid);

-- ## --

insert into p_products values (
'1a96a444-d2bd-42df-b529-fbb3c27c1abd'::uuid,
'1b4c2b82-0b5f-460a-8d0f-2d7492c083ba'::uuid,
'Aloe Vera',
'Aloe Vera is a world-renowned succulent houseplant with magical healing abilities and striking fleshy, green, architectural leaves, that will bring a touch of calm to any room in your home or office. This extremely popular indoor plant is one of the easiest plants to look after and is also excellent at purifying the air.',
'Based on recent DNA profiling, Aloe vera is thought to have originated from the Arabian peninsula. Aloe vera has been held in high regard by cultures all around the world for thousands of years. The Egyptians called the Aloe Vera the "plant of immortality" and it is said that Cleopatra used its sap on a daily basis. Today the plant is regarded as a wonder across the world as it used to treat a range of skin conditions.' || chr(10) ||
'The name, Aloe vera comes from two root words, the Arabic word "aloeh", which means bitter, and the Latin word "vera" which means truth.',
'1a96a444-d2bd-42df-b529-fbb3c27c1abd_0.webp',
10,
null,
true,
current_timestamp);
insert into p_product_sizes values ('1a96a444-d2bd-42df-b529-fbb3c27c1abd'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('1a96a444-d2bd-42df-b529-fbb3c27c1abd'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('1a96a444-d2bd-42df-b529-fbb3c27c1abd'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '1a96a444-d2bd-42df-b529-fbb3c27c1abd'::uuid, '1a96a444-d2bd-42df-b529-fbb3c27c1abd_0.webp');
insert into p_product_images values (uuid_generate_v4(), '1a96a444-d2bd-42df-b529-fbb3c27c1abd'::uuid, '1a96a444-d2bd-42df-b529-fbb3c27c1abd_1.webp');
insert into p_product_images values (uuid_generate_v4(), '1a96a444-d2bd-42df-b529-fbb3c27c1abd'::uuid, '1a96a444-d2bd-42df-b529-fbb3c27c1abd_2.webp');
insert into p_product_images values (uuid_generate_v4(), '1a96a444-d2bd-42df-b529-fbb3c27c1abd'::uuid, '1a96a444-d2bd-42df-b529-fbb3c27c1abd_3.webp');
insert into p_product_images values (uuid_generate_v4(), '1a96a444-d2bd-42df-b529-fbb3c27c1abd'::uuid, '1a96a444-d2bd-42df-b529-fbb3c27c1abd_4.webp');
insert into p_product_images values (uuid_generate_v4(), '1a96a444-d2bd-42df-b529-fbb3c27c1abd'::uuid, '1a96a444-d2bd-42df-b529-fbb3c27c1abd_5.webp');
insert into p_product_tags values ('1a96a444-d2bd-42df-b529-fbb3c27c1abd'::uuid, 'daaefefe-99c7-4c94-8f30-9ee0ea27b4dd'::uuid);
insert into p_product_tags values ('1a96a444-d2bd-42df-b529-fbb3c27c1abd'::uuid, '6c39522a-f5f5-4454-8f32-b6aecdc400a6'::uuid);
insert into p_product_tags values ('1a96a444-d2bd-42df-b529-fbb3c27c1abd'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);
insert into p_product_tags values ('1a96a444-d2bd-42df-b529-fbb3c27c1abd'::uuid, '49fb041e-6bd9-481e-af34-caf67ba92bfb'::uuid);

insert into p_product_sizes values ('1a96a444-d2bd-42df-b529-fbb3c27c1abd'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);

-- ## --
insert into p_products values (
'7548b9b2-d6c6-430e-859d-2258606286ad'::uuid,
'1b4c2b82-0b5f-460a-8d0f-2d7492c083ba'::uuid,
'Green Pearl Succulent',
'The Green Pearl or Echeveria is a succulent plant with beautiful, pale blue green fleshy leaf rosettes. Echeveria thrive in a sunny spot and only require watering in the growing season. Echeveria succulents can handle a degree of neglect and is the perfect low maintenance addition to your worktop, desk or bedside table.',
'The Green Pearl Succulent is a variety of Echeveria, a large genus made up of over 150 succulent plants. The genus was first defined in 1828, by Swiss botanist Augustin Pyramus de Candolle, who named the grouping in honour of the 18th-century Mexican botanical artist Atanasio Echeverría y Godoy.' || chr(10) ||
'Echeverias are native to mountainous terrain across Central & South America where they grow in rock faces an in gaps on cliff edges at an elevation of 300 to 1,200 metres.',
'7548b9b2-d6c6-430e-859d-2258606286ad_0.webp',
8,
null,
true,
current_timestamp);
insert into p_product_sizes values ('7548b9b2-d6c6-430e-859d-2258606286ad'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('7548b9b2-d6c6-430e-859d-2258606286ad'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('7548b9b2-d6c6-430e-859d-2258606286ad'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '7548b9b2-d6c6-430e-859d-2258606286ad'::uuid, '7548b9b2-d6c6-430e-859d-2258606286ad_0.webp');
insert into p_product_images values (uuid_generate_v4(), '7548b9b2-d6c6-430e-859d-2258606286ad'::uuid, '7548b9b2-d6c6-430e-859d-2258606286ad_1.webp');
insert into p_product_images values (uuid_generate_v4(), '7548b9b2-d6c6-430e-859d-2258606286ad'::uuid, '7548b9b2-d6c6-430e-859d-2258606286ad_2.webp');
insert into p_product_tags values ('7548b9b2-d6c6-430e-859d-2258606286ad'::uuid, 'daaefefe-99c7-4c94-8f30-9ee0ea27b4dd'::uuid);
insert into p_product_tags values ('7548b9b2-d6c6-430e-859d-2258606286ad'::uuid, '6c39522a-f5f5-4454-8f32-b6aecdc400a6'::uuid);
insert into p_product_tags values ('7548b9b2-d6c6-430e-859d-2258606286ad'::uuid, 'f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid);
insert into p_product_tags values ('7548b9b2-d6c6-430e-859d-2258606286ad'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);
insert into p_product_tags values ('7548b9b2-d6c6-430e-859d-2258606286ad'::uuid, '49fb041e-6bd9-481e-af34-caf67ba92bfb'::uuid);

-- ## --
insert into p_products values (
'195c4754-31b5-42e3-88b1-134b527c9ea6'::uuid,
'1b4c2b82-0b5f-460a-8d0f-2d7492c083ba'::uuid,
'Hoya Heart',
'The Hoya kerrii is commonly called the Hoya Heart because of its green heart-shaped leaves. It''s the perfect little gift for Valentine''s Day & Mother''s Day.',
'The Hoya Kerrii is native to Asia and the Philippines, where it actually grows as a climbing plant - the beautiful heart-shaped leaves are dotted along its vines, which can grow up to 4 meters long.' || chr(10) ||
'The Hoya plant was discovered by a botanist named Robert Brown in the late 18th century. He named the plant after a friend of his, Thomas Hoy, who was the gardener to the Duke of Northumberland.Talk about bromance!',
'195c4754-31b5-42e3-88b1-134b527c9ea6_0.webp',
6,
null,
true,
current_timestamp);
insert into p_product_sizes values ('195c4754-31b5-42e3-88b1-134b527c9ea6'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('195c4754-31b5-42e3-88b1-134b527c9ea6'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('195c4754-31b5-42e3-88b1-134b527c9ea6'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '195c4754-31b5-42e3-88b1-134b527c9ea6'::uuid, '195c4754-31b5-42e3-88b1-134b527c9ea6_0.webp');
insert into p_product_images values (uuid_generate_v4(), '195c4754-31b5-42e3-88b1-134b527c9ea6'::uuid, '195c4754-31b5-42e3-88b1-134b527c9ea6_1.webp');
insert into p_product_images values (uuid_generate_v4(), '195c4754-31b5-42e3-88b1-134b527c9ea6'::uuid, '195c4754-31b5-42e3-88b1-134b527c9ea6_2.webp');
insert into p_product_images values (uuid_generate_v4(), '195c4754-31b5-42e3-88b1-134b527c9ea6'::uuid, '195c4754-31b5-42e3-88b1-134b527c9ea6_3.webp');
insert into p_product_tags values ('195c4754-31b5-42e3-88b1-134b527c9ea6'::uuid, 'daaefefe-99c7-4c94-8f30-9ee0ea27b4dd'::uuid);
insert into p_product_tags values ('195c4754-31b5-42e3-88b1-134b527c9ea6'::uuid, '6c39522a-f5f5-4454-8f32-b6aecdc400a6'::uuid);
insert into p_product_tags values ('195c4754-31b5-42e3-88b1-134b527c9ea6'::uuid, '49fb041e-6bd9-481e-af34-caf67ba92bfb'::uuid);

-- ## --
insert into p_products values (
'369e05aa-bd18-4e65-b939-66b0f6f3edfd'::uuid,
'1b4c2b82-0b5f-460a-8d0f-2d7492c083ba'::uuid,
'Jade Plant',
'The Jade plant or Crassula ovata is a very easy to care for succulent with fleshy, oval-shaped leaves that grow from its thick stems. Native to South Africa, the Jade plant is a popular indoor plant that will thrive in a sunny spot of your home or office. They are said to bring good luck to their owners, making them a great housewarming gift.',
'The Jade plant of Crassula ovata is a succulent that is native to Southern Africa. The Jade Plant is one of the most popular houseplants around the world and has been for centuries. In some Asian countries, the Jade plant is associated with luck, riches and prosperity and is often called a money plant. The Jade plant was introduced into Europe in the 17th century and has been popular ever since.' || chr(10) ||
'According to Feng Shui, Jade plants are said to bring good luck and are often grown by the front door.',
'369e05aa-bd18-4e65-b939-66b0f6f3edfd_0.webp',
8,
null,
true,
current_timestamp);
insert into p_product_sizes values ('369e05aa-bd18-4e65-b939-66b0f6f3edfd'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('369e05aa-bd18-4e65-b939-66b0f6f3edfd'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('369e05aa-bd18-4e65-b939-66b0f6f3edfd'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '369e05aa-bd18-4e65-b939-66b0f6f3edfd'::uuid, '369e05aa-bd18-4e65-b939-66b0f6f3edfd_0.webp');
insert into p_product_images values (uuid_generate_v4(), '369e05aa-bd18-4e65-b939-66b0f6f3edfd'::uuid, '369e05aa-bd18-4e65-b939-66b0f6f3edfd_1.webp');
insert into p_product_images values (uuid_generate_v4(), '369e05aa-bd18-4e65-b939-66b0f6f3edfd'::uuid, '369e05aa-bd18-4e65-b939-66b0f6f3edfd_2.webp');
insert into p_product_images values (uuid_generate_v4(), '369e05aa-bd18-4e65-b939-66b0f6f3edfd'::uuid, '369e05aa-bd18-4e65-b939-66b0f6f3edfd_3.webp');
insert into p_product_images values (uuid_generate_v4(), '369e05aa-bd18-4e65-b939-66b0f6f3edfd'::uuid, '369e05aa-bd18-4e65-b939-66b0f6f3edfd_4.webp');
insert into p_product_images values (uuid_generate_v4(), '369e05aa-bd18-4e65-b939-66b0f6f3edfd'::uuid, '369e05aa-bd18-4e65-b939-66b0f6f3edfd_5.webp');
insert into p_product_tags values ('369e05aa-bd18-4e65-b939-66b0f6f3edfd'::uuid, 'daaefefe-99c7-4c94-8f30-9ee0ea27b4dd'::uuid);
insert into p_product_tags values ('369e05aa-bd18-4e65-b939-66b0f6f3edfd'::uuid, '6c39522a-f5f5-4454-8f32-b6aecdc400a6'::uuid);
insert into p_product_tags values ('369e05aa-bd18-4e65-b939-66b0f6f3edfd'::uuid, 'f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid);
insert into p_product_tags values ('369e05aa-bd18-4e65-b939-66b0f6f3edfd'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);
insert into p_product_tags values ('369e05aa-bd18-4e65-b939-66b0f6f3edfd'::uuid, '49fb041e-6bd9-481e-af34-caf67ba92bfb'::uuid);

-- ## --
insert into p_products values (
'a8c4054c-2015-4854-b7a9-267d7f7a469e'::uuid,
'81de93ac-8998-4a98-8fa2-070947b04569'::uuid,
'Asparagus Fern',
'The Asparagus fern houseplant has elegant soft, feathery foliage cascading on wiry stems. While young plants start life in a compact shape, as they mature they develop into climbing plants.',
'Asparagus setaceus or the Asparagus fern houseplant is a fast-growing climber species that have become naturalised and invasive across the tropics. Due to its fast growth, in many places, it has been classified as a weed.' || chr(10) ||
'The Asparagus fern houseplant is not a true fern and is actually part of the lily family, Liliaceae. It''s closely related to tulips, daylilies, amaryllis, and hostas. Unlike true ferns, which spread by spores, the Asparagus fern spreads by the seeds found in their small, blackberries.',
'a8c4054c-2015-4854-b7a9-267d7f7a469e_0.webp',
8,
null,
true,
current_timestamp);
insert into p_product_sizes values ('a8c4054c-2015-4854-b7a9-267d7f7a469e'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('a8c4054c-2015-4854-b7a9-267d7f7a469e'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('a8c4054c-2015-4854-b7a9-267d7f7a469e'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), 'a8c4054c-2015-4854-b7a9-267d7f7a469e'::uuid, 'a8c4054c-2015-4854-b7a9-267d7f7a469e_0.webp');
insert into p_product_images values (uuid_generate_v4(), 'a8c4054c-2015-4854-b7a9-267d7f7a469e'::uuid, 'a8c4054c-2015-4854-b7a9-267d7f7a469e_1.webp');
insert into p_product_images values (uuid_generate_v4(), 'a8c4054c-2015-4854-b7a9-267d7f7a469e'::uuid, 'a8c4054c-2015-4854-b7a9-267d7f7a469e_2.webp');
insert into p_product_images values (uuid_generate_v4(), 'a8c4054c-2015-4854-b7a9-267d7f7a469e'::uuid, 'a8c4054c-2015-4854-b7a9-267d7f7a469e_3.webp');
insert into p_product_tags values ('a8c4054c-2015-4854-b7a9-267d7f7a469e'::uuid, 'e8766334-b054-4955-988c-51311131a3fd'::uuid);
insert into p_product_tags values ('a8c4054c-2015-4854-b7a9-267d7f7a469e'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('a8c4054c-2015-4854-b7a9-267d7f7a469e'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);

-- ## --

insert into p_products values (
'ec030a3a-2486-4538-928c-a26f055bd4ec'::uuid,
'81de93ac-8998-4a98-8fa2-070947b04569'::uuid,
'Bird''s Nest Fern',
'The Bird''s Nest Fern or Asplenium nidus houseplant is a tropical fern with attractive feathery fronds. As one of the easiest ferns to look after, the Birds Nest Fern is a great plant for beginners. They''re also superstars at removing carbon dioxide from the air and have the ability to increase the humidity in your home.',
'The Bird''s Nest Fern houseplant is in the genus of ferns called Asplenium, traditionally referred to as spleenworts. Spleenworts were used as a medicine, from the Medieval period until the 19th century, to treat a range of conditions, including alopecia, dandruff and kidney stones.' || chr(10) ||
'Asplenium nidus has been used in traditional medicine for asthma, sores, weakness, and halitosis. The sprouts are eaten as a vegetable in Taiwan where they are often sautéed with chilli and garlic.',
'ec030a3a-2486-4538-928c-a26f055bd4ec_0.webp',
12,
null,
true,
current_timestamp);
insert into p_product_sizes values ('ec030a3a-2486-4538-928c-a26f055bd4ec'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('ec030a3a-2486-4538-928c-a26f055bd4ec'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('ec030a3a-2486-4538-928c-a26f055bd4ec'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), 'ec030a3a-2486-4538-928c-a26f055bd4ec'::uuid, 'ec030a3a-2486-4538-928c-a26f055bd4ec_0.webp');
insert into p_product_images values (uuid_generate_v4(), 'ec030a3a-2486-4538-928c-a26f055bd4ec'::uuid, 'ec030a3a-2486-4538-928c-a26f055bd4ec_1.webp');
insert into p_product_images values (uuid_generate_v4(), 'ec030a3a-2486-4538-928c-a26f055bd4ec'::uuid, 'ec030a3a-2486-4538-928c-a26f055bd4ec_2.webp');
insert into p_product_images values (uuid_generate_v4(), 'ec030a3a-2486-4538-928c-a26f055bd4ec'::uuid, 'ec030a3a-2486-4538-928c-a26f055bd4ec_3.webp');
insert into p_product_tags values ('ec030a3a-2486-4538-928c-a26f055bd4ec'::uuid, 'e8766334-b054-4955-988c-51311131a3fd'::uuid);
insert into p_product_tags values ('ec030a3a-2486-4538-928c-a26f055bd4ec'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('ec030a3a-2486-4538-928c-a26f055bd4ec'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);

-- ## --
insert into p_products values (
'd7f560c8-67ba-4ba9-9590-bdea85ab897d'::uuid,
'603b4d36-4feb-43a6-8f7d-64af5e471224'::uuid,
'Flaming Sword',
'The Vriesea Orange, commonly called the Flaming Sword is a species of Bromeliad with eye-catching, sword-shaped, brightly coloured flower that sits atop its long, arching, glossy-green foliage. Easy to look after the Flaming Sword plant is a great option if you''re looking to add a splash of tropical colour to your home or office. As a long-lasting flowering indoor plant, the Vriesea Orange is a great gift alternative to cut flowers.',
'Vriesea are colourful flowering plants native to tropical rainforests in South America. There are thought to be as many as 150 distinct species. Vriesea were discovered by Dutch botanist Hugo de Vries.' || chr(10) ||
'The bright coloured part of the plant is not actually a flower but modified leaves.',
'd7f560c8-67ba-4ba9-9590-bdea85ab897d_0.webp',
18,
null,
true,
current_timestamp);
insert into p_product_sizes values ('d7f560c8-67ba-4ba9-9590-bdea85ab897d'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('d7f560c8-67ba-4ba9-9590-bdea85ab897d'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('d7f560c8-67ba-4ba9-9590-bdea85ab897d'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), 'd7f560c8-67ba-4ba9-9590-bdea85ab897d'::uuid, 'd7f560c8-67ba-4ba9-9590-bdea85ab897d_0.webp');
insert into p_product_images values (uuid_generate_v4(), 'd7f560c8-67ba-4ba9-9590-bdea85ab897d'::uuid, 'd7f560c8-67ba-4ba9-9590-bdea85ab897d_1.webp');
insert into p_product_images values (uuid_generate_v4(), 'd7f560c8-67ba-4ba9-9590-bdea85ab897d'::uuid, 'd7f560c8-67ba-4ba9-9590-bdea85ab897d_2.webp');
insert into p_product_images values (uuid_generate_v4(), 'd7f560c8-67ba-4ba9-9590-bdea85ab897d'::uuid, 'd7f560c8-67ba-4ba9-9590-bdea85ab897d_3.webp');
insert into p_product_tags values ('d7f560c8-67ba-4ba9-9590-bdea85ab897d'::uuid, '04dcf3fd-3c1a-4402-905f-1fd4332e211e'::uuid);
insert into p_product_tags values ('d7f560c8-67ba-4ba9-9590-bdea85ab897d'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('d7f560c8-67ba-4ba9-9590-bdea85ab897d'::uuid, '6c39522a-f5f5-4454-8f32-b6aecdc400a6'::uuid);
insert into p_product_tags values ('d7f560c8-67ba-4ba9-9590-bdea85ab897d'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);
insert into p_product_tags values ('d7f560c8-67ba-4ba9-9590-bdea85ab897d'::uuid, 'f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid);

-- ## --
insert into p_products values (
'aa127519-679a-4131-aa82-c851914ebe12'::uuid,
'603b4d36-4feb-43a6-8f7d-64af5e471224'::uuid,
'Flamingo Flower Blush',
'The Flamingo Flower is a beautiful flowering indoor plant. With blush coloured palette-like leaves that enclose yellow spikes and contrasting dark green foliage, it will make a colourful tropical splash in your home. With long-lasting blooms, the Flamingo flower makes an attractive and eco alternative to replace cut flowers in your home or give as a gift. Also comes with white flowers.',
'The Pink Flamingo Flower is a variety of Anthurium andraeanum, differentiated by the colour of its modified spathes. Its botanical name Anthurium means "Tail Flower" in Greek and refers to the tail-shaped flower that protrudes from its colourful spathe. They have been introduced to many subtropical regions as an outdoor plant and is a popular houseplant across the world.' || chr(10) ||
'Despite the appearance, the "flower" part of the Flamingo Flower is actually a modified leaf rather than a true flower. Its flowers are really small and are found on the spike protruding from the coloured leaf.',
'aa127519-679a-4131-aa82-c851914ebe12_0.webp',
18,
null,
true,
current_timestamp);
insert into p_product_sizes values ('aa127519-679a-4131-aa82-c851914ebe12'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('aa127519-679a-4131-aa82-c851914ebe12'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('aa127519-679a-4131-aa82-c851914ebe12'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), 'aa127519-679a-4131-aa82-c851914ebe12'::uuid, 'aa127519-679a-4131-aa82-c851914ebe12_0.webp');
insert into p_product_images values (uuid_generate_v4(), 'aa127519-679a-4131-aa82-c851914ebe12'::uuid, 'aa127519-679a-4131-aa82-c851914ebe12_1.webp');
insert into p_product_images values (uuid_generate_v4(), 'aa127519-679a-4131-aa82-c851914ebe12'::uuid, 'aa127519-679a-4131-aa82-c851914ebe12_2.webp');
insert into p_product_images values (uuid_generate_v4(), 'aa127519-679a-4131-aa82-c851914ebe12'::uuid, 'aa127519-679a-4131-aa82-c851914ebe12_3.webp');
insert into p_product_tags values ('aa127519-679a-4131-aa82-c851914ebe12'::uuid, '04dcf3fd-3c1a-4402-905f-1fd4332e211e'::uuid);
insert into p_product_tags values ('aa127519-679a-4131-aa82-c851914ebe12'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('aa127519-679a-4131-aa82-c851914ebe12'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);
insert into p_product_tags values ('aa127519-679a-4131-aa82-c851914ebe12'::uuid, '49fb041e-6bd9-481e-af34-caf67ba92bfb'::uuid);

-- ## --
insert into p_products values (
'e51d7de0-b15c-491e-9cdb-29d8c0cff5ae'::uuid,
'603b4d36-4feb-43a6-8f7d-64af5e471224'::uuid,
'Flamingo Flower Pink',
'The Flamingo Flower is a beautiful flowering indoor plant. With pink palette-like leaves that enclose yellow spikes and contrasting dark green foliage, it will make a colourful tropical splash in your home. With long lasting blooms, the Flamingo flower makes an attractive and eco alternative to replace cut flowers in your home or give as a gift. Also comes with white flowers.',
'The Pink Flamingo Flower is a variety of Anthurium andraeanum, differentiated by the colour of its modified spathes. Its scientific name Anthurium means "Tail Flower" in Greek and refers to the tail-shaped flower that protrudes from its colourful spathe. They have been introduced to many subtropical regions as an outdoor plant and is a popular houseplant across the world.' || chr(10) ||
'Despite the appearance, the "flower" part of the Flamingo Flower is actually a modified leaf rather than a true flower. Its flowers are really small and are found on the spike protruding from the coloured leaf.',
'e51d7de0-b15c-491e-9cdb-29d8c0cff5ae_0.webp',
30,
null,
true,
current_timestamp);
insert into p_product_sizes values ('e51d7de0-b15c-491e-9cdb-29d8c0cff5ae'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('e51d7de0-b15c-491e-9cdb-29d8c0cff5ae'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('e51d7de0-b15c-491e-9cdb-29d8c0cff5ae'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), 'e51d7de0-b15c-491e-9cdb-29d8c0cff5ae'::uuid, 'e51d7de0-b15c-491e-9cdb-29d8c0cff5ae_0.webp');
insert into p_product_images values (uuid_generate_v4(), 'e51d7de0-b15c-491e-9cdb-29d8c0cff5ae'::uuid, 'e51d7de0-b15c-491e-9cdb-29d8c0cff5ae_1.webp');
insert into p_product_images values (uuid_generate_v4(), 'e51d7de0-b15c-491e-9cdb-29d8c0cff5ae'::uuid, 'e51d7de0-b15c-491e-9cdb-29d8c0cff5ae_2.webp');
insert into p_product_images values (uuid_generate_v4(), 'e51d7de0-b15c-491e-9cdb-29d8c0cff5ae'::uuid, 'e51d7de0-b15c-491e-9cdb-29d8c0cff5ae_3.webp');
insert into p_product_tags values ('e51d7de0-b15c-491e-9cdb-29d8c0cff5ae'::uuid, '04dcf3fd-3c1a-4402-905f-1fd4332e211e'::uuid);
insert into p_product_tags values ('e51d7de0-b15c-491e-9cdb-29d8c0cff5ae'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('e51d7de0-b15c-491e-9cdb-29d8c0cff5ae'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);
insert into p_product_tags values ('e51d7de0-b15c-491e-9cdb-29d8c0cff5ae'::uuid, 'f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid);

-- ## --
insert into p_products values (
'45e05d7d-48b8-422a-a92c-faa35a1ad303'::uuid,
'603b4d36-4feb-43a6-8f7d-64af5e471224'::uuid,
'Flamingo Flower White',
'The Flamingo Flower is a beautiful flowering indoor plant. With white palette-like leaves that enclose yellow spikes and contrasting dark green foliage, it will make an elegant tropical splash in your home. With long lasting blooms, the Flamingo flower makes an attractive and eco alternative to replace cut flowers in your home or give as a gift. Also comes with pink flowers.',
'The White Flamingo Flower is a variety of Anthurium andraeanum, differentiated by the colour of its modified spathes. Its scientific name Anthurium means "Tail Flower" in Greek and refers to the tail-shaped flower that protrudes from its colourful spathe. They have been introduced to many subtropical regions as an outdoor plant and is a popular houseplant across the world.' || chr(10) ||
'Despite the appearance, the "flower" part of the Flamingo Flower is actually a modified leaf rather than a true flower. Its flowers are really small and are found on the spike protruding from the coloured leaf.',
'45e05d7d-48b8-422a-a92c-faa35a1ad303_0.webp',
15,
null,
true,
current_timestamp);
insert into p_product_sizes values ('45e05d7d-48b8-422a-a92c-faa35a1ad303'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('45e05d7d-48b8-422a-a92c-faa35a1ad303'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('45e05d7d-48b8-422a-a92c-faa35a1ad303'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '45e05d7d-48b8-422a-a92c-faa35a1ad303'::uuid, '45e05d7d-48b8-422a-a92c-faa35a1ad303_0.webp');
insert into p_product_images values (uuid_generate_v4(), '45e05d7d-48b8-422a-a92c-faa35a1ad303'::uuid, '45e05d7d-48b8-422a-a92c-faa35a1ad303_1.webp');
insert into p_product_images values (uuid_generate_v4(), '45e05d7d-48b8-422a-a92c-faa35a1ad303'::uuid, '45e05d7d-48b8-422a-a92c-faa35a1ad303_2.webp');
insert into p_product_images values (uuid_generate_v4(), '45e05d7d-48b8-422a-a92c-faa35a1ad303'::uuid, '45e05d7d-48b8-422a-a92c-faa35a1ad303_3.webp');
insert into p_product_tags values ('45e05d7d-48b8-422a-a92c-faa35a1ad303'::uuid, '04dcf3fd-3c1a-4402-905f-1fd4332e211e'::uuid);
insert into p_product_tags values ('45e05d7d-48b8-422a-a92c-faa35a1ad303'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('45e05d7d-48b8-422a-a92c-faa35a1ad303'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);
insert into p_product_tags values ('45e05d7d-48b8-422a-a92c-faa35a1ad303'::uuid, 'f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid);

-- ## --

insert into p_products values (
'74d5e984-f948-43e0-bc78-da40568b0621'::uuid,
'603b4d36-4feb-43a6-8f7d-64af5e471224'::uuid,
'Moth Orchid Pink',
'The pink Moth Orchid is a stunning flowering orchid with bright pink, long-lasting blooms that sit on top of its long elegant stem. Moth orchids are relatively easy to look after, they crave high humidity and bright indirect light, so an east or west facing bathroom or kitchen is perfect. Orchids make fantastic gifts or a planet-friendly alternative to cut flowers as the blooms can last for up to a year. Moth orchids are also pet friendly! We''ve also get a purple version here, and a white version here.',
'The Moth Orchid is just one species of the 73,000 flowering plants making up the Orchid family. The Moth Orchids botanical name ''Phalaenopsis'', means "king of the moth". Native to India, Taiwan, China, Southeast Asia, New Guinea and Australia the Moth Orchid has been a popular ornamental house plant since the Victorian era.' || chr(10) ||
'Phalaenopsis (moth) orchids are thought to be over 100 million years old, they can live for over 100 years and they are the worlds most popular flowering plant with over 90 million produced in Europe every year.',
'74d5e984-f948-43e0-bc78-da40568b0621_0.webp',
25,
null,
true,
current_timestamp);
insert into p_product_sizes values ('74d5e984-f948-43e0-bc78-da40568b0621'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('74d5e984-f948-43e0-bc78-da40568b0621'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('74d5e984-f948-43e0-bc78-da40568b0621'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '74d5e984-f948-43e0-bc78-da40568b0621'::uuid, '74d5e984-f948-43e0-bc78-da40568b0621_0.webp');
insert into p_product_images values (uuid_generate_v4(), '74d5e984-f948-43e0-bc78-da40568b0621'::uuid, '74d5e984-f948-43e0-bc78-da40568b0621_1.webp');
insert into p_product_images values (uuid_generate_v4(), '74d5e984-f948-43e0-bc78-da40568b0621'::uuid, '74d5e984-f948-43e0-bc78-da40568b0621_2.webp');
insert into p_product_images values (uuid_generate_v4(), '74d5e984-f948-43e0-bc78-da40568b0621'::uuid, '74d5e984-f948-43e0-bc78-da40568b0621_3.webp');
insert into p_product_tags values ('74d5e984-f948-43e0-bc78-da40568b0621'::uuid, '04dcf3fd-3c1a-4402-905f-1fd4332e211e'::uuid);
insert into p_product_tags values ('74d5e984-f948-43e0-bc78-da40568b0621'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('74d5e984-f948-43e0-bc78-da40568b0621'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);
insert into p_product_tags values ('74d5e984-f948-43e0-bc78-da40568b0621'::uuid, 'f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid);

-- ## --

insert into p_products values (
'01eac465-037e-41bd-933a-73fe30b5cc72'::uuid,
'603b4d36-4feb-43a6-8f7d-64af5e471224'::uuid,
'Moth Orchid Purple',
'The purple Moth Orchid is a stunning flowering orchid with deep purple, long-lasting blooms that sit on top of its long elegant stem. Moth orchids are relatively easy to look after, they crave high humidity and bright indirect light, so an east or west facing bathroom or kitchen is perfect. Orchids make fantastic gifts or a planet-friendly alternative to cut flowers as the blooms can last for up to a year. Moth orchids are also pet friendly! We''ve also also got a white version here and pink version here.',
'The Moth Orchid is just one species of the 73,000 flowering plants making up the Orchid family. The Moth Orchids botanical name ''Phalaenopsis'', means "king of the moth". Native to India, Taiwan, China, Southeast Asia, New Guinea and Australia the Moth Orchid has been a popular ornamental house plant since the Victorian era.' || chr(10) ||
'Phalaenopsis (moth) orchids are thought to be over 100 million years old, they can live for over 100 years and they are the worlds most popular flowering plant with over 90 million produced in Europe every year.',
'01eac465-037e-41bd-933a-73fe30b5cc72_0.webp',
20,
null,
true,
current_timestamp);
insert into p_product_sizes values ('01eac465-037e-41bd-933a-73fe30b5cc72'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('01eac465-037e-41bd-933a-73fe30b5cc72'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('01eac465-037e-41bd-933a-73fe30b5cc72'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '01eac465-037e-41bd-933a-73fe30b5cc72'::uuid, '01eac465-037e-41bd-933a-73fe30b5cc72_0.webp');
insert into p_product_images values (uuid_generate_v4(), '01eac465-037e-41bd-933a-73fe30b5cc72'::uuid, '01eac465-037e-41bd-933a-73fe30b5cc72_1.webp');
insert into p_product_images values (uuid_generate_v4(), '01eac465-037e-41bd-933a-73fe30b5cc72'::uuid, '01eac465-037e-41bd-933a-73fe30b5cc72_2.webp');
insert into p_product_images values (uuid_generate_v4(), '01eac465-037e-41bd-933a-73fe30b5cc72'::uuid, '01eac465-037e-41bd-933a-73fe30b5cc72_3.webp');
insert into p_product_tags values ('01eac465-037e-41bd-933a-73fe30b5cc72'::uuid, '04dcf3fd-3c1a-4402-905f-1fd4332e211e'::uuid);
insert into p_product_tags values ('01eac465-037e-41bd-933a-73fe30b5cc72'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('01eac465-037e-41bd-933a-73fe30b5cc72'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);
insert into p_product_tags values ('01eac465-037e-41bd-933a-73fe30b5cc72'::uuid, 'f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid);

-- ## --

insert into p_products values (
'845a2d88-1c6f-4ce7-97c0-56ebe7c81c37'::uuid,
'603b4d36-4feb-43a6-8f7d-64af5e471224'::uuid,
'Moth Orchid White',
'The white Moth Orchid is a stunning flowering orchid with bright white, long-lasting blooms that sit on top of its long elegant stem. Moth orchids are relatively easy to look after, they crave high humidity and bright indirect light, so an east or west facing bathroom or kitchen is perfect. Orchids make fantastic gifts or a planet-friendly alternative to cut flowers as the blooms can last for up to a year. Moth orchids are also pet friendly! We''ve also also got a purple version here and pink version here.',
'The Moth Orchid is just one species of the 73,000 flowering plants making up the Orchid family. The Moth Orchids botanical name ''Phalaenopsis'', means "king of the moth". Native to India, Taiwan, China, Southeast Asia, New Guinea and Australia the Moth Orchid has been a popular ornamental house plant since the Victorian era.' || chr(10) ||
'Phalaenopsis (moth) orchids are thought to be over 100 million years old, they can live for over 100 years and they are the worlds most popular flowering plant with over 90 million produced in Europe every year.',
'845a2d88-1c6f-4ce7-97c0-56ebe7c81c37_0.webp',
25,
null,
true,
current_timestamp);
insert into p_product_sizes values ('845a2d88-1c6f-4ce7-97c0-56ebe7c81c37'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('845a2d88-1c6f-4ce7-97c0-56ebe7c81c37'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('845a2d88-1c6f-4ce7-97c0-56ebe7c81c37'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '845a2d88-1c6f-4ce7-97c0-56ebe7c81c37'::uuid, '845a2d88-1c6f-4ce7-97c0-56ebe7c81c37_0.webp');
insert into p_product_images values (uuid_generate_v4(), '845a2d88-1c6f-4ce7-97c0-56ebe7c81c37'::uuid, '845a2d88-1c6f-4ce7-97c0-56ebe7c81c37_1.webp');
insert into p_product_images values (uuid_generate_v4(), '845a2d88-1c6f-4ce7-97c0-56ebe7c81c37'::uuid, '845a2d88-1c6f-4ce7-97c0-56ebe7c81c37_2.webp');
insert into p_product_images values (uuid_generate_v4(), '845a2d88-1c6f-4ce7-97c0-56ebe7c81c37'::uuid, '845a2d88-1c6f-4ce7-97c0-56ebe7c81c37_3.webp');
insert into p_product_tags values ('845a2d88-1c6f-4ce7-97c0-56ebe7c81c37'::uuid, '04dcf3fd-3c1a-4402-905f-1fd4332e211e'::uuid);
insert into p_product_tags values ('845a2d88-1c6f-4ce7-97c0-56ebe7c81c37'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('845a2d88-1c6f-4ce7-97c0-56ebe7c81c37'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);
insert into p_product_tags values ('845a2d88-1c6f-4ce7-97c0-56ebe7c81c37'::uuid, 'f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid);

-- ## --

insert into p_products values (
'3b660ba7-59b5-4e68-a4c4-6c85c162f947'::uuid,
'603b4d36-4feb-43a6-8f7d-64af5e471224'::uuid,
'Peace Lily',
'The Peace Lily is an extremely popular plant with glossy deep green leaves and piercing white flowers that rise above the foliage. Peace lilies are relatively easy to look after and will make a calming impact in your home. Native to the steamy jungles of Bolivia, peace lilies will thrive in bright indirect light or light shade and high humidity - so perfect for a bathroom.',
'The Peace Lily is known botanically as Spathiphyllum which is derived from the Greek words for spathe and leaf. Peace lilies were first introduced into Europe in the 1870s and became increasingly popular in the 1990s, following a NASA study that demonstrated their ability to remove toxins from the air.' || chr(10) ||
'Peace Lilies are symbolic of peace and tranquillity and according to the ancient art of Feng Shui, Peace Lilies are associated with the purifying of our surroundings and soul.',
'3b660ba7-59b5-4e68-a4c4-6c85c162f947_0.webp',
8,
null,
true,
current_timestamp);
insert into p_product_sizes values ('3b660ba7-59b5-4e68-a4c4-6c85c162f947'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('3b660ba7-59b5-4e68-a4c4-6c85c162f947'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('3b660ba7-59b5-4e68-a4c4-6c85c162f947'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '3b660ba7-59b5-4e68-a4c4-6c85c162f947'::uuid, '3b660ba7-59b5-4e68-a4c4-6c85c162f947_0.webp');
insert into p_product_images values (uuid_generate_v4(), '3b660ba7-59b5-4e68-a4c4-6c85c162f947'::uuid, '3b660ba7-59b5-4e68-a4c4-6c85c162f947_1.webp');
insert into p_product_images values (uuid_generate_v4(), '3b660ba7-59b5-4e68-a4c4-6c85c162f947'::uuid, '3b660ba7-59b5-4e68-a4c4-6c85c162f947_2.webp');
insert into p_product_images values (uuid_generate_v4(), '3b660ba7-59b5-4e68-a4c4-6c85c162f947'::uuid, '3b660ba7-59b5-4e68-a4c4-6c85c162f947_3.webp');
insert into p_product_tags values ('3b660ba7-59b5-4e68-a4c4-6c85c162f947'::uuid, '04dcf3fd-3c1a-4402-905f-1fd4332e211e'::uuid);
insert into p_product_tags values ('3b660ba7-59b5-4e68-a4c4-6c85c162f947'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('3b660ba7-59b5-4e68-a4c4-6c85c162f947'::uuid, '6c39522a-f5f5-4454-8f32-b6aecdc400a6'::uuid);
insert into p_product_tags values ('3b660ba7-59b5-4e68-a4c4-6c85c162f947'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);

-- ## --

insert into p_products values (
'5d2fab66-08a0-4190-809f-911d28c75647'::uuid,
'422eb639-56a2-41d8-91bf-b8e738b83f38'::uuid,
'Chinese Evergreen ''Crete''',
'Aglaonema Crete or the Red Chinese Evergreen is an attractive colourful and relatively easy to look after plant. With splashes of pink, cream, green and red, the Red Chinese Evergreen is eye catching compact plant that will bring a tropical feel into your home.',
'Chinese Evergreens were brought to the West in 1885 at Kew Gardens. They have since been cultivated and bred into a wide range of cultivars with dozens of colours available commercially.',
'5d2fab66-08a0-4190-809f-911d28c75647_0.webp',
20,
null,
true,
current_timestamp);
insert into p_product_sizes values ('5d2fab66-08a0-4190-809f-911d28c75647'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('5d2fab66-08a0-4190-809f-911d28c75647'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('5d2fab66-08a0-4190-809f-911d28c75647'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '5d2fab66-08a0-4190-809f-911d28c75647'::uuid, '5d2fab66-08a0-4190-809f-911d28c75647_0.webp');
insert into p_product_images values (uuid_generate_v4(), '5d2fab66-08a0-4190-809f-911d28c75647'::uuid, '5d2fab66-08a0-4190-809f-911d28c75647_1.webp');
insert into p_product_images values (uuid_generate_v4(), '5d2fab66-08a0-4190-809f-911d28c75647'::uuid, '5d2fab66-08a0-4190-809f-911d28c75647_2.webp');
insert into p_product_images values (uuid_generate_v4(), '5d2fab66-08a0-4190-809f-911d28c75647'::uuid, '5d2fab66-08a0-4190-809f-911d28c75647_3.webp');
insert into p_product_tags values ('5d2fab66-08a0-4190-809f-911d28c75647'::uuid, 'de66b522-8014-4cf2-af54-bf2bdec6cb46'::uuid);
insert into p_product_tags values ('5d2fab66-08a0-4190-809f-911d28c75647'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('5d2fab66-08a0-4190-809f-911d28c75647'::uuid, '6c39522a-f5f5-4454-8f32-b6aecdc400a6'::uuid);
insert into p_product_tags values ('5d2fab66-08a0-4190-809f-911d28c75647'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);
insert into p_product_tags values ('5d2fab66-08a0-4190-809f-911d28c75647'::uuid, 'f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid);
insert into p_product_tags values ('5d2fab66-08a0-4190-809f-911d28c75647'::uuid, '49fb041e-6bd9-481e-af34-caf67ba92bfb'::uuid);

-- ## --

insert into p_products values (
'38000058-27de-47ab-8632-707f905e2d21'::uuid,
'422eb639-56a2-41d8-91bf-b8e738b83f38'::uuid,
'Clusia Princess',
'Clusia rosea or Autograph tree is an eye-catching plant with attractive thick, waxy green leaves. Easy to look after, they make a great companion on a bedside table or countertop.',
'The Clusia rosea, or the Autograph Tree, is native to tropical Central America, Mexico, Florida and parts of the Caribbean. Introduced into Hawaii, it is now one of the most invasive plants on the island and is a popular houseplant due to its easy-going nature.' || chr(10) ||
'Clusia rosea has the name autograph plant because names can be etched into their thick waxy leaves.',
'38000058-27de-47ab-8632-707f905e2d21_0.webp',
14,
null,
true,
current_timestamp);
insert into p_product_sizes values ('38000058-27de-47ab-8632-707f905e2d21'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('38000058-27de-47ab-8632-707f905e2d21'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('38000058-27de-47ab-8632-707f905e2d21'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '38000058-27de-47ab-8632-707f905e2d21'::uuid, '38000058-27de-47ab-8632-707f905e2d21_0.webp');
insert into p_product_images values (uuid_generate_v4(), '38000058-27de-47ab-8632-707f905e2d21'::uuid, '38000058-27de-47ab-8632-707f905e2d21_1.webp');
insert into p_product_images values (uuid_generate_v4(), '38000058-27de-47ab-8632-707f905e2d21'::uuid, '38000058-27de-47ab-8632-707f905e2d21_2.webp');
insert into p_product_images values (uuid_generate_v4(), '38000058-27de-47ab-8632-707f905e2d21'::uuid, '38000058-27de-47ab-8632-707f905e2d21_3.webp');
insert into p_product_tags values ('38000058-27de-47ab-8632-707f905e2d21'::uuid, 'de66b522-8014-4cf2-af54-bf2bdec6cb46'::uuid);
insert into p_product_tags values ('38000058-27de-47ab-8632-707f905e2d21'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('38000058-27de-47ab-8632-707f905e2d21'::uuid, '6c39522a-f5f5-4454-8f32-b6aecdc400a6'::uuid);
insert into p_product_tags values ('38000058-27de-47ab-8632-707f905e2d21'::uuid, 'f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid);
insert into p_product_tags values ('38000058-27de-47ab-8632-707f905e2d21'::uuid, '49fb041e-6bd9-481e-af34-caf67ba92bfb'::uuid);

-- ## --

insert into p_products values (
'1993b492-69c1-4f52-88a3-75d3f06eaefc'::uuid,
'422eb639-56a2-41d8-91bf-b8e738b83f38'::uuid,
'Corn Plant',
'The Corn Plant or Dracaena fragrans is a tropical indoor plant with waxy green foliage. Easy to look after houseplants, they will bring a splash of tropical colour into your home.',
'Europeans have been using corn plants as indoor trees since the 1800s. Corn plants are part of the Dracaena genus which, includes over 120 species. The largest member of the genus is Dracaena draco which can grow 25 feet tall and wide.' || chr(10) ||
'In Tanzania, the plant is known as "masala" to the Chagga people of Tanzania, who regard it as a holy plant.',
'1993b492-69c1-4f52-88a3-75d3f06eaefc_0.webp',
95,
null,
true,
current_timestamp);
insert into p_product_sizes values ('1993b492-69c1-4f52-88a3-75d3f06eaefc'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('1993b492-69c1-4f52-88a3-75d3f06eaefc'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('1993b492-69c1-4f52-88a3-75d3f06eaefc'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '1993b492-69c1-4f52-88a3-75d3f06eaefc'::uuid, '1993b492-69c1-4f52-88a3-75d3f06eaefc_0.webp');
insert into p_product_images values (uuid_generate_v4(), '1993b492-69c1-4f52-88a3-75d3f06eaefc'::uuid, '1993b492-69c1-4f52-88a3-75d3f06eaefc_1.webp');
insert into p_product_images values (uuid_generate_v4(), '1993b492-69c1-4f52-88a3-75d3f06eaefc'::uuid, '1993b492-69c1-4f52-88a3-75d3f06eaefc_2.webp');
insert into p_product_images values (uuid_generate_v4(), '1993b492-69c1-4f52-88a3-75d3f06eaefc'::uuid, '1993b492-69c1-4f52-88a3-75d3f06eaefc_3.webp');
insert into p_product_tags values ('1993b492-69c1-4f52-88a3-75d3f06eaefc'::uuid, 'de66b522-8014-4cf2-af54-bf2bdec6cb46'::uuid);
insert into p_product_tags values ('1993b492-69c1-4f52-88a3-75d3f06eaefc'::uuid, '6c39522a-f5f5-4454-8f32-b6aecdc400a6'::uuid);
insert into p_product_tags values ('1993b492-69c1-4f52-88a3-75d3f06eaefc'::uuid, 'ce6c2213-4a6b-490c-a110-0c636a864a23'::uuid);
insert into p_product_tags values ('1993b492-69c1-4f52-88a3-75d3f06eaefc'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);
insert into p_product_tags values ('1993b492-69c1-4f52-88a3-75d3f06eaefc'::uuid, 'f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid);

-- ## --

insert into p_products values (
'77c72968-a1d7-4167-9a81-667ec94ce0d5'::uuid,
'422eb639-56a2-41d8-91bf-b8e738b83f38'::uuid,
'Elephant Ear Polly',
'The Elephant Ear Polly or Alocasia Polly is a striking plant with thick white-veins running through its dark green leaves which can grow up to 30cm in length. This impressive plant will look great on a countertop in a kitchen or bathroom where it will thrive in the humidity.',
'Alocasia is native to the tropical rainforests of southeast Asia, with a particularly high population found in Borneo. In the wild, some species can reach heights of up to four metres tall. In some parts of Asia Alocasia species have been grown for their edible starchy tubers and have been an important staple food for thousands of years. Alocasia became a popular houseplant in the 1950s.' || chr(10) ||
'This Alocasia is Polly is a man-made hybrid that has never existed in the wild, even though it looks like it came straight out of the Amazon!',
'77c72968-a1d7-4167-9a81-667ec94ce0d5_0.webp',
22,
null,
true,
current_timestamp);
insert into p_product_sizes values ('77c72968-a1d7-4167-9a81-667ec94ce0d5'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('77c72968-a1d7-4167-9a81-667ec94ce0d5'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('77c72968-a1d7-4167-9a81-667ec94ce0d5'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '77c72968-a1d7-4167-9a81-667ec94ce0d5'::uuid, '77c72968-a1d7-4167-9a81-667ec94ce0d5_0.webp');
insert into p_product_images values (uuid_generate_v4(), '77c72968-a1d7-4167-9a81-667ec94ce0d5'::uuid, '77c72968-a1d7-4167-9a81-667ec94ce0d5_1.webp');
insert into p_product_images values (uuid_generate_v4(), '77c72968-a1d7-4167-9a81-667ec94ce0d5'::uuid, '77c72968-a1d7-4167-9a81-667ec94ce0d5_2.webp');
insert into p_product_images values (uuid_generate_v4(), '77c72968-a1d7-4167-9a81-667ec94ce0d5'::uuid, '77c72968-a1d7-4167-9a81-667ec94ce0d5_3.webp');
insert into p_product_tags values ('77c72968-a1d7-4167-9a81-667ec94ce0d5'::uuid, 'de66b522-8014-4cf2-af54-bf2bdec6cb46'::uuid);
insert into p_product_tags values ('77c72968-a1d7-4167-9a81-667ec94ce0d5'::uuid, 'b4e768f3-aa04-47ff-bf34-70c2cfc31421'::uuid);
insert into p_product_tags values ('77c72968-a1d7-4167-9a81-667ec94ce0d5'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('77c72968-a1d7-4167-9a81-667ec94ce0d5'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);

-- ## --
insert into p_products values (
'a90c9bbe-d5a4-4efa-9fb8-5f06e2472dc0'::uuid,
'422eb639-56a2-41d8-91bf-b8e738b83f38'::uuid,
'Rubber Plant ''Robusta''',
'The Rubber Plant Robusta is an extremely popular plant with attractive thick, rubbery deep green leaves. Part of the fig family, the Rubber plant is relatively easy to care for, and if kept in the right conditions, they can grow up to 3 meters tall. We''ve also got a variegated version here.',
'The Rubber Plant Robusta is a variant of the Rubber Fig botanically known as Ficus elastica. Its native habitat spans across Southeast Asia. Rubber Plants are widely grown in gardens across tropical regions of the world, and during the ''90s they became an extremely popular houseplant in Europe.' || chr(10) ||
'The incredibly strong root systems of rubber trees have been used to make bridges across rivers in India.',
'a90c9bbe-d5a4-4efa-9fb8-5f06e2472dc0_0.webp',
24,
null,
true,
current_timestamp);
insert into p_product_sizes values ('a90c9bbe-d5a4-4efa-9fb8-5f06e2472dc0'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('a90c9bbe-d5a4-4efa-9fb8-5f06e2472dc0'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('a90c9bbe-d5a4-4efa-9fb8-5f06e2472dc0'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), 'a90c9bbe-d5a4-4efa-9fb8-5f06e2472dc0'::uuid, 'a90c9bbe-d5a4-4efa-9fb8-5f06e2472dc0_0.webp');
insert into p_product_images values (uuid_generate_v4(), 'a90c9bbe-d5a4-4efa-9fb8-5f06e2472dc0'::uuid, 'a90c9bbe-d5a4-4efa-9fb8-5f06e2472dc0_1.webp');
insert into p_product_images values (uuid_generate_v4(), 'a90c9bbe-d5a4-4efa-9fb8-5f06e2472dc0'::uuid, 'a90c9bbe-d5a4-4efa-9fb8-5f06e2472dc0_2.webp');
insert into p_product_images values (uuid_generate_v4(), 'a90c9bbe-d5a4-4efa-9fb8-5f06e2472dc0'::uuid, 'a90c9bbe-d5a4-4efa-9fb8-5f06e2472dc0_3.webp');
insert into p_product_images values (uuid_generate_v4(), 'a90c9bbe-d5a4-4efa-9fb8-5f06e2472dc0'::uuid, 'a90c9bbe-d5a4-4efa-9fb8-5f06e2472dc0_4.webp');
insert into p_product_tags values ('a90c9bbe-d5a4-4efa-9fb8-5f06e2472dc0'::uuid, 'de66b522-8014-4cf2-af54-bf2bdec6cb46'::uuid);
insert into p_product_tags values ('a90c9bbe-d5a4-4efa-9fb8-5f06e2472dc0'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('a90c9bbe-d5a4-4efa-9fb8-5f06e2472dc0'::uuid, '6c39522a-f5f5-4454-8f32-b6aecdc400a6'::uuid);
insert into p_product_tags values ('a90c9bbe-d5a4-4efa-9fb8-5f06e2472dc0'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);
insert into p_product_tags values ('a90c9bbe-d5a4-4efa-9fb8-5f06e2472dc0'::uuid, 'f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid);
insert into p_product_tags values ('a90c9bbe-d5a4-4efa-9fb8-5f06e2472dc0'::uuid, '49fb041e-6bd9-481e-af34-caf67ba92bfb'::uuid);

-- ## --

insert into p_products values (
'0abc44cd-9e28-4d42-b2b2-77a5e4f794dd'::uuid,
'422eb639-56a2-41d8-91bf-b8e738b83f38'::uuid,
'Swiss Cheese Plant Big Leaf',
'This giant version of the Swiss Cheese Plant will be the piece de resistance in your home. These beautiful plants with jumbo size, dark green and glossy leaves have lots of large oval fenestrations, and will make the perfect statement stand-out plant anywhere indoors. Please be aware the smaller option is a less mature plant and will take time to grow leaves as big and fenestrated as the pictured and larger 24cm pot plant. Due to the size and delicacy of the leaves, there will often be unavoidable, small cosmetic damage to some leaves, but they can grow new leaves very quickly.',
'The Swiss Cheese plant is native to Central America. Its botanical name is Monstera deliciosa, ''deliciosa'' referring to its fruits which are similar tasting to passion fruits, and ‘monstera’ due to the huge size the plants and the leaves can grow in the wild. Swiss cheese plants shot to fame in the 1970''s and have been one of the most popular indoor plants ever since.' || chr(10) ||
'The Swiss Cheese Plant unusual roots are used in some south and Central American countries to make ropes and baskets. It''s also used to treat health problems such as arthritis and insect bites. Not just a pretty plant, right?!',
'0abc44cd-9e28-4d42-b2b2-77a5e4f794dd_0.webp',
220,
null,
true,
current_timestamp);
insert into p_product_sizes values ('0abc44cd-9e28-4d42-b2b2-77a5e4f794dd'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('0abc44cd-9e28-4d42-b2b2-77a5e4f794dd'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('0abc44cd-9e28-4d42-b2b2-77a5e4f794dd'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '0abc44cd-9e28-4d42-b2b2-77a5e4f794dd'::uuid, '0abc44cd-9e28-4d42-b2b2-77a5e4f794dd_0.webp');
insert into p_product_images values (uuid_generate_v4(), '0abc44cd-9e28-4d42-b2b2-77a5e4f794dd'::uuid, '0abc44cd-9e28-4d42-b2b2-77a5e4f794dd_1.webp');
insert into p_product_images values (uuid_generate_v4(), '0abc44cd-9e28-4d42-b2b2-77a5e4f794dd'::uuid, '0abc44cd-9e28-4d42-b2b2-77a5e4f794dd_2.webp');
insert into p_product_images values (uuid_generate_v4(), '0abc44cd-9e28-4d42-b2b2-77a5e4f794dd'::uuid, '0abc44cd-9e28-4d42-b2b2-77a5e4f794dd_3.webp');
insert into p_product_tags values ('0abc44cd-9e28-4d42-b2b2-77a5e4f794dd'::uuid, 'de66b522-8014-4cf2-af54-bf2bdec6cb46'::uuid);
insert into p_product_tags values ('0abc44cd-9e28-4d42-b2b2-77a5e4f794dd'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('0abc44cd-9e28-4d42-b2b2-77a5e4f794dd'::uuid, '6c39522a-f5f5-4454-8f32-b6aecdc400a6'::uuid);
insert into p_product_tags values ('0abc44cd-9e28-4d42-b2b2-77a5e4f794dd'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);
insert into p_product_tags values ('0abc44cd-9e28-4d42-b2b2-77a5e4f794dd'::uuid, 'f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid);
insert into p_product_tags values ('0abc44cd-9e28-4d42-b2b2-77a5e4f794dd'::uuid, '49fb041e-6bd9-481e-af34-caf67ba92bfb'::uuid);

-- ## --

insert into p_products values (
'1c035481-5f49-44ae-a2c2-3813dbdad10a'::uuid,
'52561f14-9de0-4200-a8f7-e1b2344272a1'::uuid,
'Dragon Tree',
'The Dragon Tree of Dracaena marginata houseplant is an attractive indoor tree with green and red-hued sword-like leaves that fan out from its long stems. This spiky tree is easy to look after and striking, making it a great indoor plant for your home, despite your plant parenting experience.',
'Europeans have been using corn plants as indoor trees since the 1800s. Corn plants are part of the Dracaena genus which, includes over 120 species. The largest member of the genus is Dracaena draco which can grow 25 feet tall and wide.' || chr(10) ||
'The name Dracaena is derived from a Greek word meaning female dragon. The Dragon tree was given this name due to the sticky red sap that oozes from the stems when they are cut.',
'1c035481-5f49-44ae-a2c2-3813dbdad10a_0.webp',
75,
null,
true,
current_timestamp);
insert into p_product_sizes values ('1c035481-5f49-44ae-a2c2-3813dbdad10a'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('1c035481-5f49-44ae-a2c2-3813dbdad10a'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('1c035481-5f49-44ae-a2c2-3813dbdad10a'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '1c035481-5f49-44ae-a2c2-3813dbdad10a'::uuid, '1c035481-5f49-44ae-a2c2-3813dbdad10a_0.webp');
insert into p_product_images values (uuid_generate_v4(), '1c035481-5f49-44ae-a2c2-3813dbdad10a'::uuid, '1c035481-5f49-44ae-a2c2-3813dbdad10a_1.webp');
insert into p_product_images values (uuid_generate_v4(), '1c035481-5f49-44ae-a2c2-3813dbdad10a'::uuid, '1c035481-5f49-44ae-a2c2-3813dbdad10a_2.webp');
insert into p_product_images values (uuid_generate_v4(), '1c035481-5f49-44ae-a2c2-3813dbdad10a'::uuid, '1c035481-5f49-44ae-a2c2-3813dbdad10a_3.webp');
insert into p_product_images values (uuid_generate_v4(), '1c035481-5f49-44ae-a2c2-3813dbdad10a'::uuid, '1c035481-5f49-44ae-a2c2-3813dbdad10a_4.webp');
insert into p_product_tags values ('1c035481-5f49-44ae-a2c2-3813dbdad10a'::uuid, 'b1f7fac1-5de2-4aeb-9448-f145477370cc'::uuid);
insert into p_product_tags values ('1c035481-5f49-44ae-a2c2-3813dbdad10a'::uuid, '6c39522a-f5f5-4454-8f32-b6aecdc400a6'::uuid);
insert into p_product_tags values ('1c035481-5f49-44ae-a2c2-3813dbdad10a'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);
insert into p_product_tags values ('1c035481-5f49-44ae-a2c2-3813dbdad10a'::uuid, 'f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid);

-- ## --

insert into p_products values (
'a0213616-b671-492a-966f-411bf706fdfa'::uuid,
'52561f14-9de0-4200-a8f7-e1b2344272a1'::uuid,
'Money Tree',
'The Money Tree, or Pachira aquatica, is an eye catching indoor tree with a braided trunk and dainty dark green leaves that branch out in the shape of a hand. The Money Tree is held in high esteem not just for its great looks and ability to lift your interior space, but is also thought to represent good fortune and prosperity. Money trees store water in their trunks so they are also easy to look after and they are pet-friendly too.',
'Pachira aquatica or money trees are native to tropical Central and South America. They have also become culturally important plants in Asia, where they are held in high regard due to their palmate leaves. They have become increasingly popular in recent years as an indoor tree due to their easy care and great looks.' || chr(10) ||
'The name "money tree" is believed to refer to a story of its origin, in which a poor man prayed for money, found this "odd" plant, took it home as an omen and made money selling plants grown from its seeds.',
'a0213616-b671-492a-966f-411bf706fdfa_0.webp',
18,
null,
true,
current_timestamp);
insert into p_product_sizes values ('a0213616-b671-492a-966f-411bf706fdfa'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('a0213616-b671-492a-966f-411bf706fdfa'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('a0213616-b671-492a-966f-411bf706fdfa'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), 'a0213616-b671-492a-966f-411bf706fdfa'::uuid, 'a0213616-b671-492a-966f-411bf706fdfa_0.webp');
insert into p_product_images values (uuid_generate_v4(), 'a0213616-b671-492a-966f-411bf706fdfa'::uuid, 'a0213616-b671-492a-966f-411bf706fdfa_1.webp');
insert into p_product_images values (uuid_generate_v4(), 'a0213616-b671-492a-966f-411bf706fdfa'::uuid, 'a0213616-b671-492a-966f-411bf706fdfa_2.webp');
insert into p_product_images values (uuid_generate_v4(), 'a0213616-b671-492a-966f-411bf706fdfa'::uuid, 'a0213616-b671-492a-966f-411bf706fdfa_3.webp');
insert into p_product_images values (uuid_generate_v4(), 'a0213616-b671-492a-966f-411bf706fdfa'::uuid, 'a0213616-b671-492a-966f-411bf706fdfa_4.webp');
insert into p_product_images values (uuid_generate_v4(), 'a0213616-b671-492a-966f-411bf706fdfa'::uuid, 'a0213616-b671-492a-966f-411bf706fdfa_5.webp');
insert into p_product_tags values ('a0213616-b671-492a-966f-411bf706fdfa'::uuid, 'b1f7fac1-5de2-4aeb-9448-f145477370cc'::uuid);
insert into p_product_tags values ('a0213616-b671-492a-966f-411bf706fdfa'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('a0213616-b671-492a-966f-411bf706fdfa'::uuid, '6c39522a-f5f5-4454-8f32-b6aecdc400a6'::uuid);
insert into p_product_tags values ('a0213616-b671-492a-966f-411bf706fdfa'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);
insert into p_product_tags values ('a0213616-b671-492a-966f-411bf706fdfa'::uuid, 'f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid);
insert into p_product_tags values ('a0213616-b671-492a-966f-411bf706fdfa'::uuid, '49fb041e-6bd9-481e-af34-caf67ba92bfb'::uuid);

-- ## --

insert into p_products values (
'04b33449-f765-4ed1-9c59-8c9482ece27f'::uuid,
'c52df8cf-1725-44c2-8105-e2cbe03deeab'::uuid,
'Areca Palm',
'The Areca palm houseplant has elegant arching, glossy and green fronds which bow upwards to create a beautiful butterfly effect. This beautiful indoor plant will provide instant tropical impact anywhere in your home.',
'The Areca palm houseplant is a member of the Arecaceae family, which includes all true palms. Areca palms were sold for generations under the botanical name Chrysalidocarpus lutescens. However, recent studies showed that the plant is actually closely related to other Dypsis species of its native Madagascar and so was renamed Dypsis lutescens.' || chr(10) ||
'The Areca palm was included in a NASA study on air-purifying plants and was proven to be the most effective plant out of all those tested at breaking down harmful volatile organic compounds (VOCs) found in modern homes.',
'04b33449-f765-4ed1-9c59-8c9482ece27f_0.webp',
140,
null,
true,
current_timestamp);
insert into p_product_sizes values ('04b33449-f765-4ed1-9c59-8c9482ece27f'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('04b33449-f765-4ed1-9c59-8c9482ece27f'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('04b33449-f765-4ed1-9c59-8c9482ece27f'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '04b33449-f765-4ed1-9c59-8c9482ece27f'::uuid, '04b33449-f765-4ed1-9c59-8c9482ece27f_0.webp');
insert into p_product_images values (uuid_generate_v4(), '04b33449-f765-4ed1-9c59-8c9482ece27f'::uuid, '04b33449-f765-4ed1-9c59-8c9482ece27f_1.webp');
insert into p_product_images values (uuid_generate_v4(), '04b33449-f765-4ed1-9c59-8c9482ece27f'::uuid, '04b33449-f765-4ed1-9c59-8c9482ece27f_2.webp');
insert into p_product_images values (uuid_generate_v4(), '04b33449-f765-4ed1-9c59-8c9482ece27f'::uuid, '04b33449-f765-4ed1-9c59-8c9482ece27f_3.webp');
insert into p_product_images values (uuid_generate_v4(), '04b33449-f765-4ed1-9c59-8c9482ece27f'::uuid, '04b33449-f765-4ed1-9c59-8c9482ece27f_4.webp');
insert into p_product_images values (uuid_generate_v4(), '04b33449-f765-4ed1-9c59-8c9482ece27f'::uuid, '04b33449-f765-4ed1-9c59-8c9482ece27f_5.webp');
insert into p_product_tags values ('04b33449-f765-4ed1-9c59-8c9482ece27f'::uuid, 'efd65ef6-f4ed-4c00-add7-896f969e764e'::uuid);
insert into p_product_tags values ('04b33449-f765-4ed1-9c59-8c9482ece27f'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('04b33449-f765-4ed1-9c59-8c9482ece27f'::uuid, '6c39522a-f5f5-4454-8f32-b6aecdc400a6'::uuid);
insert into p_product_tags values ('04b33449-f765-4ed1-9c59-8c9482ece27f'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);
insert into p_product_tags values ('04b33449-f765-4ed1-9c59-8c9482ece27f'::uuid, 'f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid);

-- ## --

insert into p_products values (
'32b771a5-91ab-4ffa-8643-34d5f463170f'::uuid,
'c52df8cf-1725-44c2-8105-e2cbe03deeab'::uuid,
'Kentia Palm',
'The Kentia Palm or Howea forsteriana is a stunning indoor palm tree, and is one of our most popular and favourite plants. With sweeping architectural, dark green fronds this classic plant is the perfect way to bring a lush, tropical and exotic vibe into your home. Kentia palms are hardy plants that can tolerate some neglect and a wide range of conditions making them one of our most versatile plants. What''s more they are also pet friendly and air purifying superstars!',
'
The Kentia Palm is endemic to a tiny piece of land off the coast of East Australia called Lord Howe Island, giving this tropical Palm its botanical name Howea forsteriana. Following the export of its seeds from Lord Howe in the 1870s the Kentia Palm became a very popular indoor plant in Europe during the Victorian era when people began to avidly collect exotic palms in their homes.' || chr(10) ||
'Queen Victoria was a Kentia Palm advocate, cultivating them in all of her royal residences and demanding they be planted around her coffin when she died.',
'32b771a5-91ab-4ffa-8643-34d5f463170f_0.webp',
120,
null,
true,
current_timestamp);
insert into p_product_sizes values ('32b771a5-91ab-4ffa-8643-34d5f463170f'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('32b771a5-91ab-4ffa-8643-34d5f463170f'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('32b771a5-91ab-4ffa-8643-34d5f463170f'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '32b771a5-91ab-4ffa-8643-34d5f463170f'::uuid, '32b771a5-91ab-4ffa-8643-34d5f463170f_0.webp');
insert into p_product_images values (uuid_generate_v4(), '32b771a5-91ab-4ffa-8643-34d5f463170f'::uuid, '32b771a5-91ab-4ffa-8643-34d5f463170f_1.webp');
insert into p_product_images values (uuid_generate_v4(), '32b771a5-91ab-4ffa-8643-34d5f463170f'::uuid, '32b771a5-91ab-4ffa-8643-34d5f463170f_2.webp');
insert into p_product_images values (uuid_generate_v4(), '32b771a5-91ab-4ffa-8643-34d5f463170f'::uuid, '32b771a5-91ab-4ffa-8643-34d5f463170f_3.webp');
insert into p_product_images values (uuid_generate_v4(), '32b771a5-91ab-4ffa-8643-34d5f463170f'::uuid, '32b771a5-91ab-4ffa-8643-34d5f463170f_4.webp');
insert into p_product_images values (uuid_generate_v4(), '32b771a5-91ab-4ffa-8643-34d5f463170f'::uuid, '32b771a5-91ab-4ffa-8643-34d5f463170f_5.webp');
insert into p_product_tags values ('32b771a5-91ab-4ffa-8643-34d5f463170f'::uuid, 'efd65ef6-f4ed-4c00-add7-896f969e764e'::uuid);
insert into p_product_tags values ('32b771a5-91ab-4ffa-8643-34d5f463170f'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('32b771a5-91ab-4ffa-8643-34d5f463170f'::uuid, '6c39522a-f5f5-4454-8f32-b6aecdc400a6'::uuid);
insert into p_product_tags values ('32b771a5-91ab-4ffa-8643-34d5f463170f'::uuid, 'ce6c2213-4a6b-490c-a110-0c636a864a23'::uuid);
insert into p_product_tags values ('32b771a5-91ab-4ffa-8643-34d5f463170f'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);
insert into p_product_tags values ('32b771a5-91ab-4ffa-8643-34d5f463170f'::uuid, 'f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid);
insert into p_product_tags values ('32b771a5-91ab-4ffa-8643-34d5f463170f'::uuid, '49fb041e-6bd9-481e-af34-caf67ba92bfb'::uuid);

-- ## --

insert into p_products values (
'fec65b92-797f-4595-910d-972bf6e19e1c'::uuid,
'c52df8cf-1725-44c2-8105-e2cbe03deeab'::uuid,
'Parlour Palm',
'The Parlour Palm or Chamaedorea elegans is an elegant, low-maintenance and extremely popular houseplant. Parlour palms have lush, feathery green foliage that makes them one of the most attractive plants to look at. They are also air-purifying heavyweights and are pet and child-safe, so a great option for animal lovers.',
'Parlour palms were very popular houseplants in the Victorian times. Wealthy families showcased their tropical palms and ferns, and Parlour palms were seen as an essential indoor plant to have in these collections.' || chr(10) ||
'Parlour palm fronds are used around the world in the floral industry, particularly as funeral flowers. The fronds can last up to 40 days after being cut.',
'fec65b92-797f-4595-910d-972bf6e19e1c_0.webp',
70,
null,
true,
current_timestamp);
insert into p_product_sizes values ('fec65b92-797f-4595-910d-972bf6e19e1c'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('fec65b92-797f-4595-910d-972bf6e19e1c'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('fec65b92-797f-4595-910d-972bf6e19e1c'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), 'fec65b92-797f-4595-910d-972bf6e19e1c'::uuid, 'fec65b92-797f-4595-910d-972bf6e19e1c_0.webp');
insert into p_product_images values (uuid_generate_v4(), 'fec65b92-797f-4595-910d-972bf6e19e1c'::uuid, 'fec65b92-797f-4595-910d-972bf6e19e1c_1.webp');
insert into p_product_images values (uuid_generate_v4(), 'fec65b92-797f-4595-910d-972bf6e19e1c'::uuid, 'fec65b92-797f-4595-910d-972bf6e19e1c_2.webp');
insert into p_product_images values (uuid_generate_v4(), 'fec65b92-797f-4595-910d-972bf6e19e1c'::uuid, 'fec65b92-797f-4595-910d-972bf6e19e1c_3.webp');
insert into p_product_images values (uuid_generate_v4(), 'fec65b92-797f-4595-910d-972bf6e19e1c'::uuid, 'fec65b92-797f-4595-910d-972bf6e19e1c_4.webp');
insert into p_product_tags values ('fec65b92-797f-4595-910d-972bf6e19e1c'::uuid, 'efd65ef6-f4ed-4c00-add7-896f969e764e'::uuid);
insert into p_product_tags values ('fec65b92-797f-4595-910d-972bf6e19e1c'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('fec65b92-797f-4595-910d-972bf6e19e1c'::uuid, '6c39522a-f5f5-4454-8f32-b6aecdc400a6'::uuid);
insert into p_product_tags values ('fec65b92-797f-4595-910d-972bf6e19e1c'::uuid, 'ce6c2213-4a6b-490c-a110-0c636a864a23'::uuid);
insert into p_product_tags values ('fec65b92-797f-4595-910d-972bf6e19e1c'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);
insert into p_product_tags values ('fec65b92-797f-4595-910d-972bf6e19e1c'::uuid, 'f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid);
insert into p_product_tags values ('fec65b92-797f-4595-910d-972bf6e19e1c'::uuid, '49fb041e-6bd9-481e-af34-caf67ba92bfb'::uuid);

-- ## --

insert into p_products values (
'45cd3f37-8ed8-4738-88d4-b5bda185f1ef'::uuid,
'63fa4d1d-95a6-49c7-a18d-25015bfb0f48'::uuid,
'Begonia Spotted ''Maculata''',
'Begonia Maculata or the Spotted Begonia is a beauty with two tone green and yellow leaves with a crimson pink underside. The leaves are punctuated with white polka dots making this plant really stand out.',
'
Begonias are commonly thought to originate from Brazil, but were also previously discovered in Mexico and their use in China was documented in the 14th century. The first western botanist to document the begonia was Charles Plumier, who found fibrous begonias in Brazil in 1690. He named the Begonia after his favorite botanist, Michel Begon' || chr(10) ||
'Rumour has it that the Begonia Maculata inspired Christian Louboutin to create his red heeled stilettos!',
'45cd3f37-8ed8-4738-88d4-b5bda185f1ef_0.webp',
20,
null,
true,
current_timestamp);
insert into p_product_sizes values ('45cd3f37-8ed8-4738-88d4-b5bda185f1ef'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('45cd3f37-8ed8-4738-88d4-b5bda185f1ef'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('45cd3f37-8ed8-4738-88d4-b5bda185f1ef'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '45cd3f37-8ed8-4738-88d4-b5bda185f1ef'::uuid, '45cd3f37-8ed8-4738-88d4-b5bda185f1ef_0.webp');
insert into p_product_images values (uuid_generate_v4(), '45cd3f37-8ed8-4738-88d4-b5bda185f1ef'::uuid, '45cd3f37-8ed8-4738-88d4-b5bda185f1ef_1.webp');
insert into p_product_images values (uuid_generate_v4(), '45cd3f37-8ed8-4738-88d4-b5bda185f1ef'::uuid, '45cd3f37-8ed8-4738-88d4-b5bda185f1ef_2.webp');
insert into p_product_images values (uuid_generate_v4(), '45cd3f37-8ed8-4738-88d4-b5bda185f1ef'::uuid, '45cd3f37-8ed8-4738-88d4-b5bda185f1ef_3.webp');
insert into p_product_tags values ('45cd3f37-8ed8-4738-88d4-b5bda185f1ef'::uuid, 'b4e768f3-aa04-47ff-bf34-70c2cfc31421'::uuid);
insert into p_product_tags values ('45cd3f37-8ed8-4738-88d4-b5bda185f1ef'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('45cd3f37-8ed8-4738-88d4-b5bda185f1ef'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);

-- ## --

insert into p_products values (
'c31dc6a8-df95-4364-975e-edd1b2141bba'::uuid,
'63fa4d1d-95a6-49c7-a18d-25015bfb0f48'::uuid,
'Calathea Orbifolia',
'Calathea Orbifolia houseplants are tropical plants with large beautiful green leaves which almost appear to have painted silvery-green stripes. The leaves gracefully furl-up in the evenings and un-furl in the mornings. These beautiful indoor plants provide a colour filled focal point in any room. Similarly to other Calatheas, they need indirect light or light shade, a lot of humidity and constant soil moisture to thrive; so either keep them in a bathroom or kitchen or next to a humidifier.',
'Calathea Orbifolia houseplants are held in high esteem due to their incredible range of colours and shapes. Native to tropical jungles of the Amazon, as houseplants they provide a centrepiece of colour and interest. In South America, Calatheas play a key role in local culture as they have a wide range of uses including transporting food, making roofs for houses, as well as for medicinal properties. While they are popular houseplants, due to habitat destruction in their native South America they are becoming increasingly threatened in the wild.' || chr(10) ||
'Calathea Orbifolia houseplants are said to symbolise a new beginning as each day their leaves furl up in the evening and unfurl in the morning. It is said that the phrase turning over a new leaf comes from this behaviour.',
'c31dc6a8-df95-4364-975e-edd1b2141bba_0.webp',
20,
null,
true,
current_timestamp);
insert into p_product_sizes values ('c31dc6a8-df95-4364-975e-edd1b2141bba'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('c31dc6a8-df95-4364-975e-edd1b2141bba'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('c31dc6a8-df95-4364-975e-edd1b2141bba'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), 'c31dc6a8-df95-4364-975e-edd1b2141bba'::uuid, 'c31dc6a8-df95-4364-975e-edd1b2141bba_0.webp');
insert into p_product_images values (uuid_generate_v4(), 'c31dc6a8-df95-4364-975e-edd1b2141bba'::uuid, 'c31dc6a8-df95-4364-975e-edd1b2141bba_1.webp');
insert into p_product_images values (uuid_generate_v4(), 'c31dc6a8-df95-4364-975e-edd1b2141bba'::uuid, 'c31dc6a8-df95-4364-975e-edd1b2141bba_2.webp');
insert into p_product_images values (uuid_generate_v4(), 'c31dc6a8-df95-4364-975e-edd1b2141bba'::uuid, 'c31dc6a8-df95-4364-975e-edd1b2141bba_3.webp');
insert into p_product_tags values ('c31dc6a8-df95-4364-975e-edd1b2141bba'::uuid, 'b4e768f3-aa04-47ff-bf34-70c2cfc31421'::uuid);
insert into p_product_tags values ('c31dc6a8-df95-4364-975e-edd1b2141bba'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('c31dc6a8-df95-4364-975e-edd1b2141bba'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);
insert into p_product_tags values ('c31dc6a8-df95-4364-975e-edd1b2141bba'::uuid, 'f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid);

-- ## --

insert into p_products values (
'1b65875d-6c4a-4506-87c9-2ad33f19aa07'::uuid,
'63fa4d1d-95a6-49c7-a18d-25015bfb0f48'::uuid,
'Calathea Peacock',
'The Peacock plant or Calathea makoyana houseplant, is a magnificent and colourful Calathea. They are very popular indoor plants because of their striking coloured leaves and shape.',
'Calathea Peacock houseplants are held in high esteem due to their incredible range of colours and shapes. Native to tropical jungles of the Amazon, the Calathea Peacock provides a centrepiece of colour and interest. In South America, Calatheas play a key role in local culture as they have a wide range of uses including transporting food, making roofs for houses, as well as for medicinal properties. While they are popular houseplants, due to habitat destruction in their native South America they are becoming increasingly threatened in the wild.' || chr(10) ||
'Calathea Peacock houseplants are said to symbolise a new beginning as each day their leaves furl up in the evening and unfurl in the morning. It is said that the phrase turning over a new leaf comes from this behaviour.',
'1b65875d-6c4a-4506-87c9-2ad33f19aa07_0.webp',
20,
null,
true,
current_timestamp);
insert into p_product_sizes values ('1b65875d-6c4a-4506-87c9-2ad33f19aa07'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('1b65875d-6c4a-4506-87c9-2ad33f19aa07'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('1b65875d-6c4a-4506-87c9-2ad33f19aa07'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '1b65875d-6c4a-4506-87c9-2ad33f19aa07'::uuid, '1b65875d-6c4a-4506-87c9-2ad33f19aa07_0.webp');
insert into p_product_images values (uuid_generate_v4(), '1b65875d-6c4a-4506-87c9-2ad33f19aa07'::uuid, '1b65875d-6c4a-4506-87c9-2ad33f19aa07_1.webp');
insert into p_product_images values (uuid_generate_v4(), '1b65875d-6c4a-4506-87c9-2ad33f19aa07'::uuid, '1b65875d-6c4a-4506-87c9-2ad33f19aa07_2.webp');
insert into p_product_images values (uuid_generate_v4(), '1b65875d-6c4a-4506-87c9-2ad33f19aa07'::uuid, '1b65875d-6c4a-4506-87c9-2ad33f19aa07_3.webp');
insert into p_product_tags values ('1b65875d-6c4a-4506-87c9-2ad33f19aa07'::uuid, 'b4e768f3-aa04-47ff-bf34-70c2cfc31421'::uuid);
insert into p_product_tags values ('1b65875d-6c4a-4506-87c9-2ad33f19aa07'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('1b65875d-6c4a-4506-87c9-2ad33f19aa07'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);

-- ## --

insert into p_products values (
'197228e4-20bb-4cbd-b41d-aff7ea7fa91f'::uuid,
'63fa4d1d-95a6-49c7-a18d-25015bfb0f48'::uuid,
'Calathea Pin-Stripe',
'Calathea Pin Stripe or Calathea Ornata are tropical plants with pink pinstripes decorating their large waxy deep green and maroon coloured leaves, which beautifully dance according to the circadian rhythm. These beautiful indoor plants provide a colour filled focal point in any room. Similarly to other Calatheas, they need indirect light or light shade, a lot of humidity and constant soil moisture to thrive; so either keep them in a bathroom or kitchen or next to a humidifier.',
'Calatheas are held in high esteem due to their incredible range of colours and shapes. Native to tropical jungles of the Amazon, as houseplants they provide a centrepiece of colour and interest. In South America, Calatheas play a key role in local culture as they have a wide range of uses including transporting food, making roofs for houses, as well as for medicinal properties. While they are popular houseplants, due to habitat destruction in their native South America they are becoming increasingly threatened in the wild.' || chr(10) ||
'Calatheas are said to symbolise a new beginning as each day their leaves furl up in the evening and unfurl in the morning. It is said that the phrase turning over a new leaf comes from this behaviour.',
'197228e4-20bb-4cbd-b41d-aff7ea7fa91f_0.webp',
15,
null,
true,
current_timestamp);
insert into p_product_sizes values ('197228e4-20bb-4cbd-b41d-aff7ea7fa91f'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('197228e4-20bb-4cbd-b41d-aff7ea7fa91f'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('197228e4-20bb-4cbd-b41d-aff7ea7fa91f'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '197228e4-20bb-4cbd-b41d-aff7ea7fa91f'::uuid, '197228e4-20bb-4cbd-b41d-aff7ea7fa91f_0.webp');
insert into p_product_images values (uuid_generate_v4(), '197228e4-20bb-4cbd-b41d-aff7ea7fa91f'::uuid, '197228e4-20bb-4cbd-b41d-aff7ea7fa91f_1.webp');
insert into p_product_images values (uuid_generate_v4(), '197228e4-20bb-4cbd-b41d-aff7ea7fa91f'::uuid, '197228e4-20bb-4cbd-b41d-aff7ea7fa91f_2.webp');
insert into p_product_images values (uuid_generate_v4(), '197228e4-20bb-4cbd-b41d-aff7ea7fa91f'::uuid, '197228e4-20bb-4cbd-b41d-aff7ea7fa91f_3.webp');
insert into p_product_tags values ('197228e4-20bb-4cbd-b41d-aff7ea7fa91f'::uuid, 'b4e768f3-aa04-47ff-bf34-70c2cfc31421'::uuid);
insert into p_product_tags values ('197228e4-20bb-4cbd-b41d-aff7ea7fa91f'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('197228e4-20bb-4cbd-b41d-aff7ea7fa91f'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);

-- ## --

insert into p_products values (
'1e338d98-60f2-44ff-8151-a46cfcc386dd'::uuid,
'63fa4d1d-95a6-49c7-a18d-25015bfb0f48'::uuid,
'Calathea Rattlesnake Plant',
'Calathea Rattlesnake or Calathea lancifolia houseplants are tropical plants with wavy rattlesnake shaped leaves, with a deep burgundy underside and vibrant green patterned top side. These beautiful indoor plants provide a colour filled focal point in any room. Similarly to other Calatheas, they need indirect light or light shade, a lot of humidity and constant soil moisture to thrive; so either keep them in a bathroom or kitchen or next to a humidifier.',
'Calathea Rattlesnake houseplants are held in high esteem due to their incredible range of colours and shapes. Native to tropical jungles of the Amazon, as houseplants they provide a centrepiece of colour and interest. In South America, Calatheas play a key role in local culture as they have a wide range of uses including transporting food, making roofs for houses, as well as for medicinal properties. While they are popular houseplants, due to habitat destruction in their native South America they are becoming increasingly threatened in the wild.' || chr(10) ||
'Calathea Rattlesnake houseplants are said to symbolise a new beginning as each day their leaves furl up in the evening and unfurl in the morning. It is said that the phrase turning over a new leaf comes from this behaviour.',
'1e338d98-60f2-44ff-8151-a46cfcc386dd_0.webp',
20,
null,
true,
current_timestamp);
insert into p_product_sizes values ('1e338d98-60f2-44ff-8151-a46cfcc386dd'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('1e338d98-60f2-44ff-8151-a46cfcc386dd'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('1e338d98-60f2-44ff-8151-a46cfcc386dd'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '1e338d98-60f2-44ff-8151-a46cfcc386dd'::uuid, '1e338d98-60f2-44ff-8151-a46cfcc386dd_0.webp');
insert into p_product_images values (uuid_generate_v4(), '1e338d98-60f2-44ff-8151-a46cfcc386dd'::uuid, '1e338d98-60f2-44ff-8151-a46cfcc386dd_1.webp');
insert into p_product_images values (uuid_generate_v4(), '1e338d98-60f2-44ff-8151-a46cfcc386dd'::uuid, '1e338d98-60f2-44ff-8151-a46cfcc386dd_2.webp');
insert into p_product_images values (uuid_generate_v4(), '1e338d98-60f2-44ff-8151-a46cfcc386dd'::uuid, '1e338d98-60f2-44ff-8151-a46cfcc386dd_3.webp');
insert into p_product_tags values ('1e338d98-60f2-44ff-8151-a46cfcc386dd'::uuid, 'b4e768f3-aa04-47ff-bf34-70c2cfc31421'::uuid);
insert into p_product_tags values ('1e338d98-60f2-44ff-8151-a46cfcc386dd'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('1e338d98-60f2-44ff-8151-a46cfcc386dd'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);

-- ## --

insert into p_products values (
'e7756b4a-ebf8-411e-949a-8100c96c50fd'::uuid,
'63fa4d1d-95a6-49c7-a18d-25015bfb0f48'::uuid,
'Elephant Ear Zebrina',
'The Elephant Ear zebrina or Alocasia zebrina is a statement plant with zebra-striped bouncy stems holding its dark green arrow shaped leaves. This stunning plant is a real head turner and will bring the jungle vibe into your home.',
'Alocasia is native to the tropical rainforests of southeast Asia, with a particularly high population found in Borneo. In the wild, some species can reach heights of up to four metres tall. In some parts of Asia Alocasia species have been grown for their edible starchy tubers and have been an important staple food for thousands of years. Alocasia became a popular houseplant in the 1950s.' || chr(10) ||
'The Alocasia is said to be "the tree that grows up to the heavens" and is the plant found in the fairytale of Jack and the Giant Beanstalk.',
'e7756b4a-ebf8-411e-949a-8100c96c50fd_0.webp',
25,
null,
true,
current_timestamp);
insert into p_product_sizes values ('e7756b4a-ebf8-411e-949a-8100c96c50fd'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('e7756b4a-ebf8-411e-949a-8100c96c50fd'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('e7756b4a-ebf8-411e-949a-8100c96c50fd'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), 'e7756b4a-ebf8-411e-949a-8100c96c50fd'::uuid, 'e7756b4a-ebf8-411e-949a-8100c96c50fd_0.webp');
insert into p_product_images values (uuid_generate_v4(), 'e7756b4a-ebf8-411e-949a-8100c96c50fd'::uuid, 'e7756b4a-ebf8-411e-949a-8100c96c50fd_1.webp');
insert into p_product_images values (uuid_generate_v4(), 'e7756b4a-ebf8-411e-949a-8100c96c50fd'::uuid, 'e7756b4a-ebf8-411e-949a-8100c96c50fd_2.webp');
insert into p_product_images values (uuid_generate_v4(), 'e7756b4a-ebf8-411e-949a-8100c96c50fd'::uuid, 'e7756b4a-ebf8-411e-949a-8100c96c50fd_3.webp');
insert into p_product_tags values ('e7756b4a-ebf8-411e-949a-8100c96c50fd'::uuid, 'b4e768f3-aa04-47ff-bf34-70c2cfc31421'::uuid);
insert into p_product_tags values ('e7756b4a-ebf8-411e-949a-8100c96c50fd'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('e7756b4a-ebf8-411e-949a-8100c96c50fd'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);

-- ## --

insert into p_products values (
'9808af03-977d-4f2d-96b9-82079d5c2654'::uuid,
'63fa4d1d-95a6-49c7-a18d-25015bfb0f48'::uuid,
'Rubber Plant ''Tineke''',
'The Rubber Plant Tineke is the variegated version of the Rubber Plant Roubsta. Native to Southeast Asia, the Tineke''s leaves have splashes of cream, green and pink hues, making the perfect plant to bring some exotic colour into your home. The Rubber Plant Tineke is relatively easy to care for, and if kept in the right conditions, can grow up to three meters in height. We''ve also got a dark green version here.',
'The Rubber Plant Tineke is a variant of the Rubber Fig botanically known as Ficus elastica. Its native habitat spans across Southeast Asia, from Nepal, Bhutan, northeastern India, Burma, China and Malaysia. Rubber Plants are widely grown in gardens across tropical regions of the world and during the ''90s, they became an extremely popular houseplant in Europe.' || chr(10) ||
'The incredibly strong root systems of rubber trees have been used to make bridges across rivers in India.',
'9808af03-977d-4f2d-96b9-82079d5c2654_0.webp',
20,
null,
true,
current_timestamp);
insert into p_product_sizes values ('9808af03-977d-4f2d-96b9-82079d5c2654'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('9808af03-977d-4f2d-96b9-82079d5c2654'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('9808af03-977d-4f2d-96b9-82079d5c2654'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '9808af03-977d-4f2d-96b9-82079d5c2654'::uuid, '9808af03-977d-4f2d-96b9-82079d5c2654_0.webp');
insert into p_product_images values (uuid_generate_v4(), '9808af03-977d-4f2d-96b9-82079d5c2654'::uuid, '9808af03-977d-4f2d-96b9-82079d5c2654_1.webp');
insert into p_product_images values (uuid_generate_v4(), '9808af03-977d-4f2d-96b9-82079d5c2654'::uuid, '9808af03-977d-4f2d-96b9-82079d5c2654_2.webp');
insert into p_product_images values (uuid_generate_v4(), '9808af03-977d-4f2d-96b9-82079d5c2654'::uuid, '9808af03-977d-4f2d-96b9-82079d5c2654_3.webp');
insert into p_product_images values (uuid_generate_v4(), '9808af03-977d-4f2d-96b9-82079d5c2654'::uuid, '9808af03-977d-4f2d-96b9-82079d5c2654_4.webp');
insert into p_product_tags values ('9808af03-977d-4f2d-96b9-82079d5c2654'::uuid, 'b4e768f3-aa04-47ff-bf34-70c2cfc31421'::uuid);
insert into p_product_tags values ('9808af03-977d-4f2d-96b9-82079d5c2654'::uuid, '53f762cc-2232-4c41-849d-940f133c9d46'::uuid);
insert into p_product_tags values ('9808af03-977d-4f2d-96b9-82079d5c2654'::uuid, '6c39522a-f5f5-4454-8f32-b6aecdc400a6'::uuid);
insert into p_product_tags values ('9808af03-977d-4f2d-96b9-82079d5c2654'::uuid, '99c20eaa-e087-4ccb-884b-21e2b051399f'::uuid);
insert into p_product_tags values ('9808af03-977d-4f2d-96b9-82079d5c2654'::uuid, 'f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid);
insert into p_product_tags values ('9808af03-977d-4f2d-96b9-82079d5c2654'::uuid, '49fb041e-6bd9-481e-af34-caf67ba92bfb'::uuid);

-- ## --

insert into p_products values (
'9888fcba-f5cb-4ce4-a47e-eb6046e0062a'::uuid,
'ae11cf72-8258-449c-85b3-b5cd7bdf9d6b'::uuid,
'Terrarium Planted',
'This bulb shaped terrarium is a self-sustaining green ecosystem that comes fully planted and is a perfect gift or new low-maintenance addition to your home. Comes exactly as pictured.',
'Our plant terrarium is the perfect way to create a tranquil oasis in any living space. Handcrafted with care, it features a glass enclosure that allows you to enjoy the beauty of nature up close. Inside, a carefully curated selection of plants, moss, and soil combine to create a harmonious and balanced ecosystem.' || chr(10) ||
'The plant terrarium not only adds a touch of greenery to your home but also serves as a unique and eye-catching decorative piece. Its compact size makes it suitable for any space, be it a shelf, tabletop, or even a desk. Whether placed in your living room, bedroom, or office, its vibrant display of colors and textures adds a refreshing and calming ambiance wherever it is placed.',
'9888fcba-f5cb-4ce4-a47e-eb6046e0062a_0.webp',
50,
null,
true,
current_timestamp);
insert into p_product_sizes values ('9888fcba-f5cb-4ce4-a47e-eb6046e0062a'::uuid, 'b43a5ce3-9b58-48ae-b795-4c9bb4ae41c3'::uuid);
insert into p_product_sizes values ('9888fcba-f5cb-4ce4-a47e-eb6046e0062a'::uuid, '8f1d1ec2-4a80-4957-a6e3-63b02df039fd'::uuid);
insert into p_product_sizes values ('9888fcba-f5cb-4ce4-a47e-eb6046e0062a'::uuid, '2dca3234-241f-4bb8-acb1-bf25f1ef9384'::uuid);
insert into p_product_images values (uuid_generate_v4(), '9888fcba-f5cb-4ce4-a47e-eb6046e0062a'::uuid, '9888fcba-f5cb-4ce4-a47e-eb6046e0062a_0.webp');
insert into p_product_images values (uuid_generate_v4(), '9888fcba-f5cb-4ce4-a47e-eb6046e0062a'::uuid, '9888fcba-f5cb-4ce4-a47e-eb6046e0062a_1.webp');
insert into p_product_images values (uuid_generate_v4(), '9888fcba-f5cb-4ce4-a47e-eb6046e0062a'::uuid, '9888fcba-f5cb-4ce4-a47e-eb6046e0062a_2.webp');
insert into p_product_images values (uuid_generate_v4(), '9888fcba-f5cb-4ce4-a47e-eb6046e0062a'::uuid, '9888fcba-f5cb-4ce4-a47e-eb6046e0062a_3.webp');
insert into p_product_images values (uuid_generate_v4(), '9888fcba-f5cb-4ce4-a47e-eb6046e0062a'::uuid, '9888fcba-f5cb-4ce4-a47e-eb6046e0062a_4.webp');
insert into p_product_images values (uuid_generate_v4(), '9888fcba-f5cb-4ce4-a47e-eb6046e0062a'::uuid, '9888fcba-f5cb-4ce4-a47e-eb6046e0062a_5.webp');
insert into p_product_tags values ('9888fcba-f5cb-4ce4-a47e-eb6046e0062a'::uuid, 'febe149d-050f-419a-97a2-1a25616c8e9f'::uuid);
insert into p_product_tags values ('9888fcba-f5cb-4ce4-a47e-eb6046e0062a'::uuid, '6c39522a-f5f5-4454-8f32-b6aecdc400a6'::uuid);
insert into p_product_tags values ('9888fcba-f5cb-4ce4-a47e-eb6046e0062a'::uuid, 'f750fa0a-5812-4f0d-a25a-4eae606a110e'::uuid);
insert into p_product_tags values ('9888fcba-f5cb-4ce4-a47e-eb6046e0062a'::uuid, '49fb041e-6bd9-481e-af34-caf67ba92bfb'::uuid);

-- ## --

insert into p_blog_posts values (uuid_generate_v4(),
'The Ultimate Guide to Indoor Gardening: Tips & Tricks for Thriving Plants',
'Discover the secrets to creating a flourishing indoor garden. From choosing the right plants and containers to mastering watering techniques and ensuring proper sunlight, this guide will help you transform your home into a green oasis',
null, 'post-1.png', to_date('15-11-2023 15:32', 'dd-mm-yyyy hh24:mi'));

insert into p_blog_posts values (uuid_generate_v4(),
'10 Low-Maintenance Houseplants for Busy People',
'Don''t let a hectic schedule deter you from enjoying the beauty of plants. Explore our curated list of low-maintenance houseplants that will thrive even if you forget to water them occasionally. Bring nature indoors without adding any additional stress to your life.',
null, 'post-2.jpg', to_date('07-11-2023 11:40', 'dd-mm-yyyy hh24:mi'));

insert into p_blog_posts values (uuid_generate_v4(),
'Unleashing the Power of Plants: How Greenery Boosts Mental Health',
'Did you know that being around plants can have a significant positive impact on your mental health? In this article, we''ll delve into the fascinating world of horticultural therapy and explore the various ways in which plants can improve your well-being and reduce stress.',
null, 'post-3.jpg', to_date('04-11-2023 16:14', 'dd-mm-yyyy hh24:mi'));

insert into p_blog_posts values (uuid_generate_v4(),
'From Seed to Harvest: A Beginner''s Guide to Growing Your Own Vegetable Garden',
'Have you always dreamt of growing your own fresh vegetables but didn''t know where to start? Look no further! This comprehensive guide will teach you everything you need to know, from preparing the soil and selecting the right vegetables to understanding when and how to harvest your crops. Get ready to savor the delicious rewards of your hard work.',
null, 'post-4.jp', to_date('29-10-2023 09:48', 'dd-mm-yyyy hh24:mi'));

