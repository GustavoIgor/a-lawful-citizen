extends Node

var example_dialogue = [
	{"name": "Agente", "text": "Você trouxe os documentos?"},
	{"name": "Protagonista", "text": "Ainda não, estava sendo vigiado."},
	{"name": "Agente", "text": "Cuidado. Eles estão de olho em você."}
]

var exemplo = [
	{"name": "Resistente", "text": "Você tem que decidir agora."},
	{
		"name": "Resistente",
		"text": "Quem vai receber os documentos?",
		"choices": ["Entregar para a resistência", "Levar até o governo", "Destruir os documentos"]
	},
	{"name": "Você", "text": "Está feito."}
]
