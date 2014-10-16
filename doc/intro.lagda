\section{Introduction}
\label{sec:intro}

Writing proof terms in type theory is hard and often tedious.
Interactive proof assistants based on type theory, such as
Agda~\citep{agda} or Coq~\citeyearpar{coq}, take very different approaches to
facilitating this process.

The Coq proof assistant has two distinct language fragments. Besides
the programming language Gallina, there is a separate tactic language
for writing and programming proof scripts. Together with several
highly customizable tactics, the tactic language Ltac can provide
powerful proof automation~\citep{chlipala}. Having to introduce a
separate tactic language, however, seems at odds with the spirit of
type theory, where a single language is used for both proof and
computation.  Having a separate language for programming proofs has
its drawbacks. Programmers need to learn another language to automate
proofs. Debugging Ltac programs can be difficult and the resulting
proof automation may be inefficient~\citep{brabaint}.

Agda does not have Coq's segregation of proof and programming
language.  Instead, programmers are encouraged to automate proofs by
writing their own solvers~\citep{ulf-tphols}. In combination with
Agda's reflection mechanism~\citep{agda-relnotes-228,van-der-walt}, developers can write
powerful automatic decision procedures~\citep{allais}. Unfortunately,
not all proofs are easily automated in this fashion. In that case,
the user is forced to interact with the integrated development
environment and manually construct a proof term step by step.

This paper tries to combine the best of both worlds by implementing a
library for proof search \emph{within} Agda itself. More specifically,
this paper makes the several novel contributions.

\todo{Emphasise how this fits perfectly with the mathematics of
  program construction. And say what the key advantages of our approach are.}

\begin{itemize}
\item %
  We show how to implement a Prolog interpreter in the style of
  \citet{stutterheim} in Agda (Section~\ref{sec:prolog}). Note that,
  in contrast to Agda, resolving a Prolog query need not terminate.
  Using coinduction, however, we can write an interpreter for Prolog
  that is \emph{total}.
\item %
  Resolving a Prolog query results in a substitution that, when applied
  to the goal, produces a solution in the form of a term that can be
  derived from the given rules.
  We extend our interpreter to also produce a trace of the applied
  rules, which allow us to produce a proof term that is a witness to
  the validity of the resulting substitution (Section~\ref{sec:proofs}).
\item %
  We integrate this proof search algorithm with Agda's
  \emph{reflection} mechanism (Section~\ref{sec:reflection}). This
  enables us to \emph{quote} the type of a lemma we would like to
  prove, pass this term as the goal of our proof search algorithm, and
  finally, \emph{unquote} the resulting proof term, thereby proving
  the desired lemma.
\pepijn{
  Add an item to explain the example of sub-lists.
}

Although Agda already has built-in proof search
functionality~\citep{lindblad}, we believe that exploring the
first-class proof automation defined in this paper is still
worthwhile. For the moment, however, we would like to defer discussing
the various forms of proof automation until after we have
presented our work (Section~\ref{sec:discussion}).

All the code described in this paper is freely available from
GitHub.\footnote{
  See \url{https://github.com/pepijnkokke/AutoInAgda}.
} It is important to emphasize that all our code
is written in the safe fragment of Agda: it does not depend on any
postulates or foreign functions; all definitions pass Agda's
termination checker; and all metavariables are resolved.

%%% Local Variables:
%%% mode: latex
%%% TeX-master: t
%%% TeX-command-default: "rake"
%%% End:
