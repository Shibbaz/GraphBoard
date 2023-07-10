package router

import(
	. "library"
)
type Gateway struct {
	Routers *map[string]*Router
}

func (gateway *Gateway) Listen(){
	for _, router := range *gateway.Routers {
		Async(router.Listen)
	}
}

func NewGateway(routers map[string]*Router) *Gateway {
	return &Gateway{
		Routers: &routers,
	}
}