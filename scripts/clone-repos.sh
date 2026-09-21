#!/usr/bin/env bash
# Recreates the ~/git folder tree and clones every repo into the same
# layout this machine had on 2026-09-16, checked out to the branch each
# repo was on at capture time. Nuwebs/* deliberately excluded (2026-09-21,
# no longer needed) — re-add manually if that ever changes.
#
# Requires SSH keys / git credentials already restored for the github.com
# and gitlab.uis.edu.co remotes below (run this after phase 3's identity
# restore, not before).
#
# Usage: scripts/clone-repos.sh [target-dir]   (default: ~/git)

set -euo pipefail

GIT_ROOT="${1:-$HOME/git}"
mkdir -p "$GIT_ROOT"

# path|remote_url|branch   (branch "HEAD" means it was on a detached HEAD;
# the script just leaves those on the remote's default branch)
REPOS='
General/color_compose||HEAD
General/dotfiles|git@github.com:danny2768/dotfiles.git|master
General/Epimetheus|git@github.com:danny2768/Epimetheus.git|feat/DashboardSupport
General/info_actividades|https://github.com/Jeansupre/info_actividades.git|main
General/portfolio-legacy/Portfolio-frontend|git@github.com:danny2768/Portfolio-frontend.git|feat/home
General/Portfolio/Portfolio-Epimetheus|git@github.com:danny2768/Portfolio-Epimetheus.git|main
General/Portfolio/Portfolio-Prometheus|git@github.com:danny2768/Portfolio-Prometheus.git|develop
General/prometheus|git@github.com:danny2768/Prometheus.git|feat/UI-Rework
General/Ryujinx/Ryujinx|git@github.com:danny2768/Ryujinx.git|master
General/Test||master
Minint/conflictividad|https://gitlab.uis.edu.co/min-inter/sistema/apps/conflictividad.git|develop
Minint/sncpv-front|https://gitlab.uis.edu.co/min-inter/sistema/apps/sncpv-front.git|develop
Rsi/auth/back-authorization-nestjs|https://gitlab.uis.edu.co/rsi/seguridad/back-authorization-nestjs.git|fix/rutas-navegacion-multi-rol-collapse
Rsi/auth/seguridad-frontend|https://gitlab.uis.edu.co/rsi/seguridad/seguridad-frontend.git|feat/1468_back_nestjs
Rsi/back-actualizaciondatos|https://gitlab.uis.edu.co/rsi/kernel/actualizaciondatos.git|fix/DynamicForms
Rsi/back-autoregistro|https://gitlab.uis.edu.co/rsi/rrhh/autoregistro/back-autoregistro.git|develop
Rsi/backend-integration|https://gitlab.uis.edu.co/rsi/kernel/backend-integration.git|develop
Rsi/back-notifications|https://gitlab.uis.edu.co/rsi/kernel/back-notifications.git|feat/CustomSubjectEmails
Rsi/core/core-backend|https://gitlab.uis.edu.co/rsi/core/core-backend.git|develop
Rsi/core/core-frontend|https://gitlab.uis.edu.co/rsi/core/core-frontend.git|develop
Rsi/evDocente/back-evaluacion-docente|https://gitlab.uis.edu.co/rsi/secretaria-general/back-evaluacion-docente.git|feat/EvDocenteAdmin
Rsi/evDocente/front-evaluacion-docente|https://gitlab.uis.edu.co/rsi/secretaria-general/front-evaluacion-docente.git|develop
Rsi/evDocente/front-evaluacion-docente-hashpassui|https://gitlab.uis.edu.co/rsi/secretaria-general/front-evaluacion-docente-hashpassui.git|develop
Rsi/front-admisiones-publico|https://gitlab.uis.edu.co/rsi/academico/admisiones/front-admisiones-publico.git|develop
Rsi/front-base-line|https://gitlab.uis.edu.co/rsi/configuracion/front-base-line.git|Feat/Single_spa_predev
Rsi/front-carnet|https://gitlab.uis.edu.co/rsi/mobile/frontend/carnet/front-carnet.git|Fix/RecoverPassIssue
Rsi/front-contratos|https://gitlab.uis.edu.co/rsi/financiero/contratacion/contratos/front-contratos.git|chore/UpdateSubmodules
Rsi/front-presupuesto|https://gitlab.uis.edu.co/rsi/financiero/presupuesto/front-presupuesto.git|develop
Rsi/polizas/ai-skills|https://gitlab.uis.edu.co/rsi/kernel/ai-skills.git|HEAD
Rsi/polizas/ai-skills.wiki|https://gitlab.uis.edu.co/rsi/kernel/ai-skills.wiki.git|develop
Rsi/polizas/back-polizas|https://gitlab.uis.edu.co/rsi/financiero/contabilidad/back-polizas.git|develop
Rsi/polizas/front-polizas|https://gitlab.uis.edu.co/rsi/financiero/contabilidad/front-polizas.git|UIrework
Rsi/uis-root-config|https://gitlab.uis.edu.co/rsi/kernel/uis-root-config.git|develop
'

skipped=()
failed=()
cloned=()

while IFS='|' read -r path url branch; do
  [ -z "$path" ] && continue
  dest="$GIT_ROOT/$path"

  if [ -z "$url" ]; then
    echo "SKIP   (no remote, local-only repo — restore from backup by hand): $path"
    skipped+=("$path")
    continue
  fi

  if [ -d "$dest/.git" ]; then
    echo "EXIST  already cloned: $path"
    continue
  fi

  echo "CLONE  $path  <-  $url"
  mkdir -p "$(dirname "$dest")"
  if git clone --quiet "$url" "$dest"; then
    if [ -n "$branch" ] && [ "$branch" != "HEAD" ]; then
      git -C "$dest" checkout --quiet "$branch" 2>/dev/null \
        || echo "       note: branch '$branch' not found on remote, staying on default"
    fi
    cloned+=("$path")
  else
    echo "       FAILED: $path"
    failed+=("$path")
  fi
done <<< "$REPOS"

echo
echo "Done. ${#cloned[@]} cloned, ${#skipped[@]} skipped (no remote), ${#failed[@]} failed."
[ "${#skipped[@]}" -gt 0 ] && { echo "no-remote repos to restore manually:"; printf '  - %s\n' "${skipped[@]}"; }
[ "${#failed[@]}" -gt 0 ]  && { echo "clone failures to retry:"; printf '  - %s\n' "${failed[@]}"; }
