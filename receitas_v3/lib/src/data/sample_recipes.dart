import '../models/recipe.dart';

class SampleRecipes {
  static const doces = <Recipe>[
    Recipe(
      title: 'Cocada Baiana',
      shortDescription: 'Clássica de coco, macia por dentro.',
      ingredients: [
        '2 xíc. de coco fresco ralado',
        '1 e 1/2 xíc. de açúcar',
        '1/2 xíc. de água',
        '1 pitada de sal',
        '1 col. (sopa) de manteiga',
      ],
      methodOfPreparation:
          'Leve ao fogo a água, açúcar e sal até formar calda em ponto de fio. '
          'Junte o coco e a manteiga, mexendo até desgrudar do fundo. '
          'Coloque porções em superfície untada e deixe firmar.',
    ),
    Recipe(
      title: 'Bolinho de Estudante',
      shortDescription: 'Tapioca com coco, frito e polvilhado com canela.',
      ingredients: [
        '2 xíc. de tapioca granulada',
        '1 xíc. de leite de coco',
        '1/2 xíc. de açúcar',
        '1 xíc. de coco ralado',
        'Uma pitada de sal',
        'Óleo para fritar',
        'Açúcar e canela para polvilhar',
      ],
      methodOfPreparation:
          'Hidrate a tapioca no leite de coco por 20 min. '
          'Misture açúcar, coco e sal. Modele bolinhos alongados. '
          'Frite em óleo quente até dourar e passe em açúcar com canela.',
    ),
    Recipe(
      title: 'Quindim',
      shortDescription: 'Gema e coco, brilho intenso.',
      ingredients: [
        '10 gemas',
        '1 xíc. de açúcar',
        '1 xíc. de coco ralado fino',
        '2 col. (sopa) de manteiga derretida',
        'Manteiga e açúcar para untar as forminhas',
      ],
      methodOfPreparation:
          'Peneire as gemas (sem raspar). Misture com açúcar, coco e manteiga. '
          'Descanse 10 min. Despeje em formas untadas e açucaradas. '
          'Asse em banho-maria a 180°C até firmar e dourar.',
    ),
  ];

  static const salgadas = <Recipe>[
    Recipe(
      title: 'Empadão Goiano',
      shortDescription: 'Recheio farto com frango, linguiça e guariroba.',
      ingredients: [
        'Massa podre (farinha, manteiga, ovos, sal)',
        '500g de frango cozido e desfiado',
        '200g de linguiça calabresa em cubos',
        '200g de queijo minas padrão em cubos',
        '1 xíc. de milho verde',
        'Guariroba em lâminas (ou palmito, se não encontrar)',
        'Azeitonas, cheiro-verde, alho, cebola, sal e pimenta',
        '1 gema para pincelar',
      ],
      methodOfPreparation:
          'Refogue cebola, alho, linguiça e frango; junte milho, guariroba, azeitonas e acerte o sal. '
          'Forre a forma com a massa, coloque o recheio e o queijo, cubra com massa. '
          'Pincele gema e asse a 200°C até dourar.',
    ),
    Recipe(
      title: 'Arroz com Pequi',
      shortDescription: 'Símbolo do Cerrado, aroma marcante.',
      ingredients: [
        '2 xíc. de arroz lavado e escorrido',
        '6 a 8 caroços de pequi lavado',
        '2 col. (sopa) de óleo ou banha',
        '1/2 cebola picada',
        '2 dentes de alho picados',
        'Sal a gosto',
        'Água quente (aprox. 4 xíc.)',
        'Cheiro-verde para finalizar',
      ],
      methodOfPreparation:
          'Refogue cebola e alho no óleo; junte o pequi e refogue alguns minutos. '
          'Acrescente o arroz e frite levemente. '
          'Cubra com água quente, ajuste o sal e cozinhe até secar. '
          'Finalize com cheiro-verde. (Evite roer o caroço de pequi.)',
    ),
  ];

  static const bebidas = <Recipe>[
    Recipe(
      title: 'Caipirinha de Limão',
      shortDescription: 'O clássico brasileiro com cachaça.',
      ingredients: [
        '1 limão tahiti',
        '2 col. (sopa) de açúcar',
        '60 ml de cachaça',
        'Gelo a gosto',
      ],
      methodOfPreparation:
          'Corte o limão em 4–6 pedaços, macere com o açúcar no copo. '
          'Adicione gelo até o topo e complete com cachaça. Mexa e sirva.',
    ),
    Recipe(
      title: 'Batida de Coco',
      shortDescription: 'Cremosa e gelada.',
      ingredients: [
        '100 ml de leite de coco',
        '60 ml de cachaça (ou vodka)',
        '2 col. (sopa) de leite condensado',
        'Gelo',
      ],
      methodOfPreparation:
          'Bata tudo no liquidificador até ficar homogêneo e sirva imediatamente.',
    ),
    Recipe(
      title: 'Capeta (drink baiano)',
      shortDescription: 'Festa garantida: guaraná em pó e especiarias.',
      ingredients: [
        '50 ml de vodka (ou cachaça)',
        '1 col. (chá) de guaraná em pó',
        '2 col. (sopa) de leite condensado',
        '2 col. (sopa) de creme de leite',
        '100 ml de leite (opcional, para mais cremosidade)',
        'Gelo',
        'Canela em pó para finalizar',
      ],
      methodOfPreparation:
          'Bata todos os ingredientes com gelo no liquidificador até espumar. '
          'Sirva polvilhando canela por cima.',
    ),
  ];
}
