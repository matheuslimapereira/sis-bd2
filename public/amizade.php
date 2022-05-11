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

        <h2>amizade</h2>
        <?php
        require 'mysql_server.php';

        $conexao = RetornaConexao();

        $leitor_id = 'leitor_id';
        $amigo_id = 'amigo_id';
        /*TODO-1: Adicione uma variavel para cada coluna */


        $sql =
            'SELECT ' . $leitor_id .
            '     , ' . $amigo_id .
            /*TODO-2: Adicione cada variavel a consulta abaixo */
            '  FROM amizade';


        $resultado = mysqli_query($conexao, $sql);
        if (!$resultado) {
            echo mysqli_error($conexao);
        }



        $cabecalho =
            '<table>' .
            '    <tr>' .
            '        <th>' . $leitor_id . '</th>' .
            '        <th>' . $amigo_id . '</th>' .
            /* TODO-3: Adicione as variaveis ao cabeçalho da tabela */
            '    </tr>';

        echo $cabecalho;

        if (mysqli_num_rows($resultado) > 0) {

            while ($registro = mysqli_fetch_assoc($resultado)) {
                echo '<tr>';

                echo '<td>' . $registro[$leitor_id] . '</td>' .
                    '<td>' . $registro[$amigo_id] . '</td>';
                    /* TODO-4: Adicione a tabela os novos registros. */

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