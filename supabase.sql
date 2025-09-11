-- Supabase schema for Balance Tracker
create table if not exists public.user_plans (
  user_id uuid primary key references auth.users(id) on delete cascade,
  plan text not null default 'free',
  expiry date
);
alter table public.user_plans enable row level security;
create policy "select own plan" on public.user_plans for select to authenticated using (auth.uid()=user_id);
create policy "insert own plan" on public.user_plans for insert to authenticated with check (auth.uid()=user_id);
create policy "update own plan" on public.user_plans for update to authenticated using (auth.uid()=user_id) with check (auth.uid()=user_id);