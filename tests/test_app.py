def test_get_index(client):
    assert client.get("/").status_code == 200


def test_post_index_fails(client):
    assert client.post("/").status_code == 405
