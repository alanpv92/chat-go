alter table "public"."chats" drop constraint "chats_receiver_id_fkey",
  add constraint "chats_receiver_id_fkey"
  foreign key ("receiver_id")
  references "public"."users"
  ("id") on update cascade on delete cascade;
