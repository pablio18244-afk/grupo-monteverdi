-- Ejecutar en el SQL Editor de Supabase. Activar autenticación Email/Password.
create table if not exists public.matriz_registros (
 clave text not null,
 usuario uuid not null references auth.users(id) on delete cascade,
 contenido jsonb not null,
 actualizado timestamptz not null default now(),
 primary key (clave, usuario)
);
alter table public.matriz_registros enable row level security;
create policy "Solo propietario puede leer" on public.matriz_registros for select to authenticated using (usuario = (select auth.uid()));
create policy "Solo propietario puede insertar" on public.matriz_registros for insert to authenticated with check (usuario = (select auth.uid()));
create policy "Solo propietario puede actualizar" on public.matriz_registros for update to authenticated using (usuario = (select auth.uid())) with check (usuario = (select auth.uid()));
