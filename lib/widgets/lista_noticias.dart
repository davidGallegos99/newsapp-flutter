import 'package:flutter/material.dart';
import 'package:news_app/models/news_response.dart';
import 'package:news_app/theme/app_theme.dart';

class ListaNoticias extends StatelessWidget {
  const ListaNoticias({Key? key, required this.lista}) : super(key: key);
  final List<Article> lista;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (BuildContext context, int index) {
        return _Noticia(noticia: lista[index], index: index);
      },
    );
  }
}

class _Noticia extends StatelessWidget {
  const _Noticia({
    Key? key,
    required this.noticia,
    required this.index,
  }) : super(key: key);

  final Article noticia;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TarjetaTopBar(
          noticia: noticia,
          index: index,
        ),
        _TarjetaTitulo(
          noticia: noticia,
        ),
        _TarjetaImagen(noticia: noticia),
        _TarjetaBody(
          noticia: noticia,
        ),
        const _TarjetaBotones(),
        const SizedBox(
          height: 10,
        ),
        const Divider()
      ],
    );
  }
}

class _TarjetaBotones extends StatelessWidget {
  const _TarjetaBotones({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {},
            fillColor: Apptheme.theme.colorScheme.secondary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.star_border),
          ),
          const SizedBox(
            width: 10,
          ),
          RawMaterialButton(
            onPressed: () {},
            fillColor: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.more),
          )
        ],
      ),
    );
  }
}

class _TarjetaBody extends StatelessWidget {
  const _TarjetaBody({
    Key? key,
    required this.noticia,
  }) : super(key: key);
  final Article noticia;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(noticia.description ?? ''),
    );
  }
}

class _TarjetaImagen extends StatelessWidget {
  const _TarjetaImagen({
    Key? key,
    required this.noticia,
  }) : super(key: key);

  final Article noticia;

  @override
  Widget build(BuildContext context) {
    final ImageProvider image = noticia.urlToImage != ''
        ? NetworkImage(noticia.urlToImage!)
        : const AssetImage('assets/no-image.png') as ImageProvider;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        child: FadeInImage(
            width: double.infinity,
            placeholder: const AssetImage('assets/giphy.gif'),
            image: image),
      ),
    );
  }
}

class _TarjetaTitulo extends StatelessWidget {
  const _TarjetaTitulo({
    Key? key,
    required this.noticia,
  }) : super(key: key);

  final Article noticia;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        noticia.title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _TarjetaTopBar extends StatelessWidget {
  const _TarjetaTopBar({
    Key? key,
    required this.noticia,
    required this.index,
  }) : super(key: key);

  final Article noticia;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            '${index + 1}',
            style: TextStyle(color: Apptheme.theme.accentColor),
          ),
          Text(
            noticia.source.name,
          ),
        ],
      ),
    );
  }
}
