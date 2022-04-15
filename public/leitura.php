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

        <h2>leitura</h2>
        <?php
        require 'mysql_server.php';

        $conexao = RetornaConexao();

        $quemleu = 'quemleu';
        $quallivro = 'quallivro';
        $inicio_leitura = 'inicio_leitura';
        $fim_leitura = 'fim_leitura';
        $classificacao = 'classificacao';
        $comentario = 'comentario';
        /*TODO-1: Adicione uma variavel para cada coluna */


        $sql =
            'SELECT ' . $quemleu .
            '     , ' . $quallivro .
            '     , ' . $inicio_leitura .
            '     , ' . $fim_leitura .
            '     , ' . $classificacao .
            '     , ' . $comentario .
            /*TODO-2: Adicione cada variavel a consulta abaixo */
            '  FROM leitura';


        $resultado = mysqli_query($conexao, $sql);
        if (!$resultado) {
            echo mysqli_error($conexao);
        }



        $cabecalho =
            '<table>' .
            '    <tr>' .
            '        <th>' . $quemleu . '</th>' .
            '        <th>' . $quallivro . '</th>' .
            /* TODO-3: Adicione as variaveis ao cabeçalho da tabela */
            '        <th>' . $inicio_leitura . '</th>' .
            '        <th>' . $fim_leitura . '</th>' .
            '        <th>' . $classificacao . '</th>' .
            '        <th>' . $comentario . '</th>' .
            '    </tr>';

        echo $cabecalho;

        if (mysqli_num_rows($resultado) > 0) {

            while ($registro = mysqli_fetch_assoc($resultado)) {
                echo '<tr>';

                echo '<td>' . $registro[$quemleu] . '</td>' .
                    '<td>' . $registro[$quallivro] . '</td>' .
                    /* TODO-4: Adicione a tabela os novos registros. */
                    '<td>' . $registro[$inicio_leitura] . '</td>' .
                    '<td>' . $registro[$fim_leitura] . '</td>' .
                    '<td>' . $registro[$classificacao] . '</td>' .
                    '<td>' . $registro[$comentario] . '</td>';
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