CREATE TABLE "friends" (
  "user_id" foreign_key,
  "friend_id" foreign_key,
  "status" varchar[10] NOT NULL,
  "created_at" timestamp NOT NULL,
  "accepted_at" timestamp NOT NULL,
  PRIMARY KEY ("user_id", "friend_id")
);

CREATE TABLE "users" (
  "id" integer PRIMARY KEY,
  "username" varchar[30] UNIQUE NOT NULL,
  "email" varchar[255] UNIQUE NOT NULL,
  "password_hash" varchar[255] NOT NULL,
  "full_name" varchar[120] NOT NULL,
  "birth_date" date,
  "bio" text,
  "location" varchar[100],
  "profile_picture_url" varchar[500],
  "job_title" varchar[100],
  "company" varchar[100],
  "experience_years" smallint,
  "github_url" varchar[255],
  "linkedin_url" varchar[255],
  "is_active" boolean,
  "created_at" timestamp NOT NULL,
  "updated_at" timestamp NOT NULL
);

CREATE TABLE "posts" (
  "id" integer PRIMARY KEY,
  "user_id" foreign_key NOT NULL,
  "content" text,
  "link_url" varchar[500],
  "created_at" timestamp NOT NULL,
  "updated_at" timestamp NOT NULL
);

CREATE TABLE "likes" (
  "id" integer PRIMARY KEY,
  "user_id" foreign_key NOT NULL,
  "post_id" foreign_key NOT NULL,
  "comment_id" foreign_key NOT NULL,
  "created_at" timestamp NOT NULL
);

CREATE TABLE "comments" (
  "id" integer PRIMARY KEY,
  "user_id" foreign_key NOT NULL,
  "post_id" foreign_key NOT NULL,
  "parent_comment_id" foreign_key NOT NULL,
  "content" text,
  "created_at" timestamp NOT NULL,
  "updated_at" timestamp NOT NULL
);

COMMENT ON COLUMN "posts"."content" IS 'Content of the post';

COMMENT ON COLUMN "comments"."content" IS 'Content of the post';

ALTER TABLE "posts" ADD CONSTRAINT "posts_user" FOREIGN KEY ("user_id") REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "friends" ADD CONSTRAINT "friends_requester" FOREIGN KEY ("user_id") REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "friends" ADD CONSTRAINT "friends_receiver" FOREIGN KEY ("friend_id") REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "comments" ADD CONSTRAINT "comments_user" FOREIGN KEY ("user_id") REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "comments" ADD CONSTRAINT "comments_post" FOREIGN KEY ("post_id") REFERENCES "posts" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "comments" ADD CONSTRAINT "comments_parent" FOREIGN KEY ("parent_comment_id") REFERENCES "comments" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "likes" ADD CONSTRAINT "likes_user" FOREIGN KEY ("user_id") REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "likes" ADD CONSTRAINT "likes_post" FOREIGN KEY ("post_id") REFERENCES "posts" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "likes" ADD CONSTRAINT "likes_comment" FOREIGN KEY ("comment_id") REFERENCES "comments" ("id") DEFERRABLE INITIALLY IMMEDIATE;
