CREATE TABLE "public"."usernotifications" ("id" uuid NOT NULL DEFAULT gen_random_uuid(), "sender_id" uuid NOT NULL, "notification_token" text NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("sender_id") REFERENCES "public"."users"("id") ON UPDATE cascade ON DELETE cascade);
CREATE EXTENSION IF NOT EXISTS pgcrypto;
