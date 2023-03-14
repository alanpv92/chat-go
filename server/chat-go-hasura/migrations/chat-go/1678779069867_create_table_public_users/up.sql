CREATE TABLE "public"."users" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "email" text NOT NULL, "password" text NOT NULL, "user_name" text NOT NULL, "salt" text NOT NULL, PRIMARY KEY ("id") , UNIQUE ("id"), UNIQUE ("email"), UNIQUE ("user_name"));
CREATE EXTENSION IF NOT EXISTS pgcrypto;
