/* forgot */
CREATE TABLE "forgot"(
"seq" integer AUTO_INCREMENT(0,1) PRIMARY KEY,
"email" character varying(102) NOT NULL,
"token" character varying(102) NOT NULL,
"used" integer default 0
);
CREATE UNIQUE INDEX "forgot_email_token_idx" on "forgot" ("email","token");

select * from forgot order by seq desc;


