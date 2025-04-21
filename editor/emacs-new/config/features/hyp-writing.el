;; Configuration relating to writing

(use-package powerthesaurus
  :straight (:source melpa)
  :general-config
  (:states 'visual
	   :prefix "<SPC> p"
	   "s" 'powerthesaurus-lookup-synonyms-dwim
	   "a" 'powerthesaurus-lookup-antonyms-dwim
	   "r" 'powerthesaurus-lookup-related-dwim
	   "d" 'powerthesaurus-lookup-definitions-dwim
	   "w" 'powerthesaurus-lookup-sentences-dwim))
