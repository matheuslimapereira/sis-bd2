<!DOCTYPE html>

<head>
    <style>
        .content {
            max-width: 500px;
            margin: auto;
        }
    </style>
</head>

<html>

<body>
    <div class="content">
        <h1>Bibliófilo's</h1>

        <h2>livros</h2>
        <?php
        require 'mysql_server.php';

        $conexao = RetornaConexao();

        $nome_livro = 'nome_livro';
        $autor_livro = 'autor_livro';
        $categoria_livro = 'categoria_livro';
        $data_livro = 'data_livro';
        /*TODO-1: Adicione uma variavel para cada coluna */


        $sql =
            'SELECT ' . $nome_livro .
            '     , ' . $autor_livro .
            '     , ' . $categoria_livro .
            '     , ' . $data_livro .
            /*TODO-2: Adicione cada variavel a consulta abaixo */
            '  FROM livros';


        $resultado = mysqli_query($conexao, $sql);
        if (!$resultado) {
            echo mysqli_error($conexao);
        }



        $cabecalho =
            '<table>' .
            '    <tr>' .
            '        <th>' . $nome_livro . '</th>' .
            '        <th>' . $autor_livro . '</th>' .
            /* TODO-3: Adicione as variaveis ao cabeçalho da tabela */
            '        <th>' . $categoria_livro . '</th>' .
            '    </tr>';

        echo $cabecalho;

        if (mysqli_num_rows($resultado) > 0) {

            while ($registro = mysqli_fetch_assoc($resultado)) {
                echo '<tr>';

                echo '<td>' . $registro[$nome_livro] . '</td>' .
                    '<td>' . $registro[$autor_livro] . '</td>' .
                    /* TODO-4: Adicione a tabela os novos registros. */
                    '<td>' . $registro[$categoria_livro] . '</td>';
                echo '</tr>';
            }
            echo '</table>';
        } else {
            echo '';
        }
        FecharConexao($conexao);
        ?>
    </div>
</body>

</html>