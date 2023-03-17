alter table "public"."chats" drop constraint "chats_sender_id_fkey",
  add constraint "chats_sender_id_fkey"
  foreign key ("sender_id")
  references "public"."users"
  ("id") on update restrict on delete restrict;
