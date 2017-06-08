create schema if not exists `pollforfun`;
use pollforfun;


create table question(
	question_index int NOT NULL AUTO_INCREMENT,
	id varchar (255) NOT NULL,
	question varchar(1000),
	option_type varchar(255),
	userId varchar(255) NOT NULL,
	qr_code_url varchar(1000),
	media_url varchar(1000),
	created_date timestamp NOT NULL default current_timestamp,
	modified_date timestamp NOT NULL default current_timestamp on update current_timestamp,
	primary key (id),
	INDEX `question_index` (`question_index`)
	);




create table options(
	id varchar(255) NOT NULL,
	question_id varchar(255) NOT NULL,
	option_value varchar(255) NOT NULL,
	option_type varchar(255) NOT NULL,
	vote_count int,
	created_date timestamp NOT NULL default current_timestamp,
	modified_date timestamp NOT NULL default current_timestamp on update current_timestamp,
	PRIMARY KEY (id),
	INDEX `question_id` (`question_id`),
	CONSTRAINT fk_question_id FOREIGN KEY (question_Id)
	REFERENCES question(id)
	);


create table user (
	id varchar(255) NOT NULL,
	user_name varchar(255) NOT NULL UNIQUE,
	password varchar(255) NOT NULL,
	created_date timestamp NOT NULL default current_timestamp,
	modified_date timestamp NOT NULL default current_timestamp on update current_timestamp,
	PRIMARY KEY (id),
	INDEX `user_name_idx` (`user_name`)
	);


create table user_poll(
	user_id varchar(255) NOT NULL,
	option_id varchar(255) NOT NUll,
	question_id varchar(255) NOT NULL,
	created_date timestamp NOT NULL default current_timestamp,
	modified_date timestamp NOT NULL default current_timestamp on update current_timestamp,
	PRIMARY KEY (user_id, option_id, question_id),
	CONSTRAINT fk_poll_question_id FOREIGN KEY (question_id)
	REFERENCES question(id),
	CONSTRAINT fk_poll_user_id FOREIGN KEY (user_id)
	REFERENCES user(id),
	CONSTRAINT fk_poll_option_id FOREIGN KEY (option_id)
	REFERENCES options(id)
);


create table user_comments(
comment_index int NOT NULL AUTO_INCREMENT,
question_id varchar(255) NOT NULL,	
user_id varchar(255) NOT NULL,
comment varchar (500),
created_date timestamp NOT NULL default current_timestamp,
modified_date timestamp NOT NULL default current_timestamp on update current_timestamp,
CONSTRAINT fk_comment_question_id FOREIGN KEY ( question_id )
REFERENCES question(id),
CONSTRAINT fk_comment_user_id FOREIGN KEY ( user_id )
REFERENCES user(id),
primary key (comment_index),
INDEX `user_comment_question_idx` (`question_id`)
);



create table user_details (
	id varchar(255) NOT NULL,
	user_id  varchar(255) NOT NULL UNIQUE,
	age_group varchar(255),
	gender varchar(255),	
	created_date timestamp NOT NULL default current_timestamp,
	modified_date timestamp NOT NULL default current_timestamp on update current_timestamp,
	CONSTRAINT fk_user_id FOREIGN KEY (user_id)
	REFERENCES user(id),
	INDEX `user_id_idx` (`user_id`)
	);

create table secure_user (
	id varchar(255) NOT NULL,
	user_id  varchar(255) NOT NULL UNIQUE,
	salt blob NOT NULL,
	created_date timestamp NOT NULL default current_timestamp,
	modified_date timestamp NOT NULL default current_timestamp on update current_timestamp,
	CONSTRAINT fk_secure_user_id FOREIGN KEY (user_id)
	REFERENCES user(id),
	INDEX `secure_user_id_idx` (`user_id`)
	);

create table user_personal_info (
	id varchar(255) NOT NULL,
	user_id  varchar(255) NOT NULL UNIQUE,
	full_name  varchar(255) NOT NULL,
	email varchar(255) NOT NULL,
	contact varchar(255),
	created_date timestamp NOT NULL default current_timestamp,
	modified_date timestamp NOT NULL default current_timestamp on update current_timestamp,
	CONSTRAINT fk_user_personal_info_id FOREIGN KEY (user_id)
	REFERENCES user(id),
	INDEX `info_user_id_idx` (`user_id`)
	);


create table pending_friend_request(
	id varchar(255) NOT NULL,
	requester_user_id  varchar(255) NOT NULL,
	accepter_user_id  varchar(255) NOT NULL,
		created_date timestamp NOT NULL default current_timestamp,
	modified_date timestamp NOT NULL default current_timestamp on update current_timestamp,
	CONSTRAINT fk_requester_user_id FOREIGN KEY (requester_user_id)
	REFERENCES user(id),
	CONSTRAINT fk_accepter_user_id FOREIGN KEY (accepter_user_id)
	REFERENCES user(id),
	PRIMARY KEY (requester_user_id, accepter_user_id)
	);


create table user_friends(
	user_id varchar(255) NOT NULL,
	friends_id varchar(255) NOT NULL,
	created_date timestamp NOT NULL default current_timestamp,
	modified_date timestamp NOT NULL default current_timestamp on update current_timestamp,
	PRIMARY KEY ( user_id, friends_id),
	CONSTRAINT fk_self_user_id FOREIGN KEY (user_id)
	REFERENCES user(id),
	CONSTRAINT fk_friend_user_id FOREIGN KEY (friends_id)
	REFERENCES user(id) 
);





create table user_statistics(
	id varchar(255) NOT NULL,
	user_id varchar(255) NOT NULL,
	questions_asked int,
	questions_answered int,
	user_comments int,
	created_date timestamp NOT NULL default current_timestamp,
	modified_date timestamp NOT NULL default current_timestamp on update current_timestamp,
	PRIMARY KEY (user_id),
	INDEX `user_stats_user_id_idx` (`user_id`),
	CONSTRAINT fk_user_status_userid_id FOREIGN KEY (user_id)
	REFERENCES user(id)
);





