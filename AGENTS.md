# AGENTS.md: xatc-agent documentation

The public documentation site for xatc-agent, AI air traffic control for X-Plane 12. This repository is **public** so that GitHub Pages can serve it. The product's own repositories (the gateway, the client, the ATC view, the sign-in) are private.

## Requirements

- **A public repository for pilot-facing documentation** (owner, 2026-10-06: "can you create a new public repo that contains documentation about how to use, configure, the features of the agentic ai for xplane? It needs to be public so we can use github pages"). The site covers how to use it, how to configure it, and its features. It follows the older xatc documentation site: MkDocs Material, the `gh-pages` branch, a strict build.
- **Record every requirement the owner states here**, dated, with his words, in the same change that carries it out.

## What must never be in this repository

Everything here is public, including the history. Before every commit, check that none of this is in it:

- cloud account ids, resource names or addresses (the gateway's runtime ARN, bucket names, the sign-in domain, the sign-in app client id, user pool ids);
- anyone's email address or name, including in screenshots (the client's demo data shows a real name: replace it before taking a screenshot);
- flight ids, session ids, recordings, transcripts or tracks of real flights;
- costs, and anything about the owner's cloud setup beyond what `docs/how-it-works.md` says;
- the private repositories' code, their internal notes, and the owner's or the testers' words from them.

The pilot gets the gateway address and the client package from the owner, privately. The site says so and never prints them.

## Writing

- **For pilots, not developers.** Say what the pilot sees and does. No wave numbers, protocol versions, pull request numbers or module names.
- **Only what is built.** A feature goes on the site when it is in a released client or gateway. What is not built is listed plainly ("Not built yet" in `docs/features/index.md`).
- **Phraseology in examples is illustrative.** Use the product's own example flight (N547GA, Seattle to Portland) and keep examples consistent with what the controller really says.
- **`docs/privacy.md` must stay true.** It describes what is sent and kept. Change it in the same change as any documentation of a feature that changes what is sent or kept, and quote the recording question's wording exactly as the client shows it.
- Screenshots come from the client's demo data, never from a real flight.

## Sources

The site is written from the private repositories, which stay the source of truth: the client's README (the window, settings, sign-in, sessions), the gateway's pilot capability map (what each position does) and its system overview (how it works). When they change, change the site.

## Checks

| What | Command |
|---|---|
| Build, strict | `mkdocs build --strict` |
| Preview | `mkdocs serve` |
| Publish (from a clean `main`) | `scripts/publish-docs.sh` |

## Git

Work goes on a branch and opens as a pull request. Commit messages end with the co-author line the harness gives.
