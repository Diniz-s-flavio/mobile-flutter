import '../models/recipe.dart';

class SampleRecipes {
  static const doces = <Recipe>[
    Recipe(
      title: 'Brigadeiro',
      shortDescription: 'Docinho de chocolate cremoso.',
      ingredients: [
        '1 lata de leite condensado',
        '2 colheres (sopa) de chocolate em pó',
        '1 colher (sopa) de manteiga',
        'Granulado para enrolar'
      ],
      methodOfPreparation:
        'Leve ao fogo baixo o leite condensado, chocolate e manteiga, mexendo até desgrudar do fundo. Deixe esfriar, enrole e passe no granulado.',
    ),
    Recipe(
      title: 'Bolo de Cenoura',
      shortDescription: 'Com cobertura de chocolate.',
      ingredients: [
        '3 cenouras médias',
        '3 ovos',
        '1/2 xíc. de óleo',
        '2 xíc. de açúcar',
        '2 xíc. de farinha',
        '1 col. (sopa) fermento'
      ],
      methodOfPreparation:
        'Bata cenoura, ovos e óleo. Misture açúcar e farinha, finalize com fermento. Asse a 180°C. Cubra com calda de chocolate.',
    ),
    Recipe(
      title: 'Mousse de Maracujá',
      shortDescription: 'Rápida e aerada.',
      ingredients: [
        '1 lata de leite condensado',
        '1 lata de creme de leite',
        '1 medida da lata de suco de maracujá concentrado'
      ],
      methodOfPreparation:
        'Bata tudo no liquidificador e leve à geladeira por 3 horas.',
    ),
  ];


  static const salgadas = <Recipe>[
    Recipe(
      title: 'Lasanha de Carne',
      shortDescription: 'Camadas suculentas ao molho.',
      ingredients: [
        'Massa para lasanha',
        '500g carne moída',
        'Molho de tomate',
        'Queijo muçarela',
        'Presunto',
        'Temperos a gosto'
      ],
      methodOfPreparation:
        'Refogue o alho-poró. Misture ovos, creme e queijo. Despeje sobre a massa pré-assada e leve ao forno.',
    ),
    Recipe(
      title: 'Frango Grelhado com Ervas',
      shortDescription: 'Suculento e prático para o dia a dia.',
      ingredients: [
        'Peito de frango',
        'Alho',
        'Limão',
        'Ervas (alecrim, tomilho)',
        'Azeite, sal e pimenta'
      ],
      methodOfPreparation:
        'Tempere e grelhe em frigideira quente até dourar e cozinhar por completo.',
    ),
  ];


  static const bebidas = <Recipe>[
    Recipe(
      title: 'Limonada Suiça',
      shortDescription: 'Refrescante e cítrica.',
      ingredients: [
        '2 limões com casca',
        '1 litro de água gelada',
        'Açúcar a gosto',
        'Gelo'
      ],
      methodOfPreparation:
        'Bata tudo no liquidificador rapidamente e coe. Sirva com gelo.',
    ),
    Recipe(
      title: 'Chocolate Quente Cremoso',
      shortDescription: 'Perfeito para dias frios.',
      ingredients: [
        '500ml leite',
        '2 col. (sopa) cacau',
        '2 col. (sopa) açúcar',
        '1 col. (sopa) amido',
        'Canela (opcional)'
      ],
      methodOfPreparation:
        'Misture os ingredientes e leve ao fogo baixo até engrossar, mexendo sempre.',
    ),
    Recipe(
      title: 'Suco Verde',
      shortDescription: 'Energético e nutritivo.',
      ingredients: [
        '1 folha de couve',
        '1 maçã',
        'Suco de 1 limão',
        '300ml de água',
        'Gelo'
      ],
      methodOfPreparation:
        'Bata tudo no liquidificador e coe, se desejar.',
    ),
  ];
}