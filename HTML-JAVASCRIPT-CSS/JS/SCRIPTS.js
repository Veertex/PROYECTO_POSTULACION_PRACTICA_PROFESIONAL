formulario = document.querySelector("#formulario_");
formulario.addEventListener("submit", (e) => {
  e.preventDefault();

  const nuevoObjetoGenerico = {
    campo_1: document.querySelector("input[name=campo_1]").value,
    campo_2: document.querySelector("input[name=campo_2]").value,
    campo_3: document.querySelector("input[name=campo_3]").value,
    campo_4: document.querySelector("input[name=campo_4]").value,
    campo_5: document.querySelector("input[name=campo_5]").value,
  };

  enviarJSONConRegistro(JSON.stringify(nuevoObjetoGenerico)).then(() => {
    actualizarLista(obtenerJSONConRegistrosAsync());
  });
});

async function enviarJSONConRegistro(objetoJSON) {
  const responseJson = await fetch(
    "http://localhost/ARCHIVOS_PHP/API_PHP.php?funcion=registrarObjeto",
    {
      method: "POST",
      body: objetoJSON,
      headers: {
        "Content-Type": "application/json;charset=utf-8",
      },
    }
  );
  return responseJson.json();
}

async function obtenerJSONConRegistrosAsync() {
  const responseJson = await fetch(
    "http://localhost/ARCHIVOS_PHP/API_PHP.php?funcion=obtenerLista",
    {
      method: "GET",
      headers: {
        "Content-Type": "application/json;charset=utf-8",
      },
    }
  );
  return responseJson.json();
}

async function agregarJSONConRegistrosALista(JSONConRegistros) {
  agregarObjetosALista(await JSONConRegistros);
}

async function actualizarLista(JSONConRegistros) {
  limpiarLista(document.querySelector(".tabla tbody"));
  agregarJSONConRegistrosALista(await JSONConRegistros);
}

function limpiarLista(listaHTML) {
  while (listaHTML.firstChild) {
    listaHTML.removeChild(listaHTML.firstChild);
  }
}

function agregarObjetosALista(arregloDeObjetos) {
  for (let indiceDeArray in arregloDeObjetos) {
    let filaTabla = document.createElement("tr");
    for (let indiceDeObjeto in arregloDeObjetos[indiceDeArray]) {
      let celdaTabla = document.createElement("td");
      celdaTabla.appendChild(
        document.createTextNode(arregloDeObjetos[indiceDeArray][indiceDeObjeto])
      );
      filaTabla.appendChild(celdaTabla);
    }
    document.querySelector(".tabla tbody").appendChild(filaTabla);
  }
}
actualizarLista(obtenerJSONConRegistrosAsync());
